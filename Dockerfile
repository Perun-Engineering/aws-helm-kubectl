### Define ARGS we are using in FROM
ARG ALPINE_PYTHON
ARG ALPINE_VERSION

### --------- STEP 1: Build AWS CLI
FROM public.ecr.aws/docker/library/python:${ALPINE_PYTHON} AS builder

ARG AWS_CLI_VERSION

# Install build dependencies
RUN apk add --no-cache git unzip groff build-base libffi-dev cmake

# Clone and build AWS CLI
RUN git clone --single-branch --depth 1 -b ${AWS_CLI_VERSION} https://github.com/aws/aws-cli.git

WORKDIR /aws-cli
RUN python -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    scripts/installers/make-exe && \
    unzip -q dist/awscli-exe.zip && \
    aws/install --bin-dir /aws-cli-bin

# Verify installation and reduce image size
RUN /aws-cli-bin/aws --version && \
    rm -rf /usr/local/aws-cli/v2/current/dist/aws_completer \
           /usr/local/aws-cli/v2/current/dist/awscli/data/ac.index \
           /usr/local/aws-cli/v2/current/dist/awscli/examples && \
    find /usr/local/aws-cli/v2/current/dist/awscli/botocore/data -name examples-1.json -delete

### --------- STEP 2: Build final image
FROM public.ecr.aws/docker/library/alpine:${ALPINE_VERSION}

ARG ALPINE_VERSION
ARG AWS_CLI_VERSION
ARG KUBE_VERSION
ARG HELM_VERSION
ARG SOPS_VERSION
ARG HELM_SECRETS_VERSION
ARG HELM_S3_VERSION
ARG HELMFILE_VERSION
ARG HELM_DIFF_VERSION
ARG TARGETOS
ARG TARGETARCH

LABEL maintainer="Dmytro Sirant" \
      company="Opsworks Co" \
      alpine.version="${ALPINE_VERSION}" \
      aws-cli.version="${AWS_CLI_VERSION}" \
      kubectl.version="${KUBE_VERSION}" \
      helm.version="${HELM_VERSION}" \
      sops.version="${SOPS_VERSION}" \
      helm.secrets.version="${HELM_SECRETS_VERSION}" \
      helm-s3.version="${HELM_S3_VERSION}" \
      helmfile.version="${HELMFILE_VERSION}" \
      helm-diff.version="${HELM_DIFF_VERSION}"

# Copy AWS CLI from builder stage
COPY --from=builder /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=builder /aws-cli-bin/ /usr/local/bin/

# Install system dependencies and tools
RUN apk -U upgrade && \
    apk add --no-cache \
        ca-certificates \
        bash \
        git \
        openssh \
        gettext \
        jq \
        yq \
        curl \
        && \
    # Download and install kubectl
    wget -q https://dl.k8s.io/release/v${KUBE_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl -O /usr/local/bin/kubectl && \
    # Download and install helm
    wget -q https://get.helm.sh/helm-v${HELM_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz -O - | tar -xzO ${TARGETOS}-${TARGETARCH}/helm > /usr/local/bin/helm && \
    # Download and install sops
    wget -q https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.${TARGETOS}.${TARGETARCH} -O /usr/local/bin/sops && \
    # Download and install helmfile
    wget -q https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_${HELMFILE_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz -O - | tar -xzO helmfile > /usr/local/bin/helmfile && \
    # Make binaries executable
    chmod +x /usr/local/bin/helm /usr/local/bin/kubectl /usr/local/bin/sops /usr/local/bin/helmfile && \
    # Create config directory with proper permissions
    mkdir /config && \
    chmod g+rwx /config /root && \
    # Add stable helm repo
    helm repo add "stable" "https://charts.helm.sh/stable" --force-update && \
    # Install helm plugins
    helm plugin install https://github.com/jkroepke/helm-secrets --version v${HELM_SECRETS_VERSION} && \
    helm plugin install https://github.com/hypnoglow/helm-s3.git --version ${HELM_S3_VERSION} && \
    helm plugin install https://github.com/databus23/helm-diff --version ${HELM_DIFF_VERSION} && \
    # Verify installations
    kubectl version --client && \
    helm version && \
    aws --version && \
    sops --version && \
    helmfile --version

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD kubectl version --client && helm version --short && aws --version || exit 1

# Create non-root user for security
RUN addgroup -g 1000 appuser && \
    adduser -D -u 1000 -G appuser appuser && \
    chown -R appuser:appuser /config

USER appuser
WORKDIR /config
