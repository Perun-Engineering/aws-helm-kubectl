# AWS Helm Kubectl Docker Image

Multi-architecture Docker image containing AWS CLI, Helm, Kubectl, and other commonly used Kubernetes tools.

## Supported Architectures

- `linux/amd64`
- `linux/arm64`

## Available Tags (Kubectl Versions)

$KUBE_LIST

## Components Versions

All current images include the following tools:

| Component | Version |
|-----------|---------|
| Alpine | $ALPINE_VERSION |
| Helm | $HELM_VERSION |
| AWS CLI | $AWS_CLI_VERSION |
| SOPS | $SOPS_VERSION |
| Helm Secrets Plugin | $HELM_SECRETS_VERSION |
| Helm S3 Plugin | $HELM_S3_VERSION |
| Helm Diff Plugin | $HELM_DIFF_VERSION |
| Helmfile | $HELMFILE_VERSION |

## Usage

Pull the specific kubectl version you need:
```bash
docker pull perunengineering/aws-helm-kubectl:1.33.2
```

Or from GitHub Container Registry:
```bash
docker pull ghcr.io/perun-engineering/aws-helm-kubectl:1.33.2
```

## Examples

### Basic Usage
```bash
# Run with AWS credentials from environment
docker run --rm -it \
  -e AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY \
  -e AWS_DEFAULT_REGION \
  perunengineering/aws-helm-kubectl:1.33.2 \
  kubectl get nodes
```

### Mount kubeconfig
```bash
# Mount your kubeconfig file
docker run --rm -it \
  -v ~/.kube:/home/appuser/.kube:ro \
  perunengineering/aws-helm-kubectl:1.33.2 \
  kubectl get pods
```

### Interactive Shell
```bash
# Start an interactive shell
docker run --rm -it \
  -v $(pwd):/workspace \
  perunengineering/aws-helm-kubectl:1.33.2 \
  /bin/bash
```

## Security

This image runs as a non-root user (`appuser`) for enhanced security. The working directory is `/config` and is owned by the `appuser`.

## Health Check

The image includes a health check that verifies all tools are working correctly:
- kubectl version check
- helm version check
- aws version check

## Building Locally

```bash
# Build for specific Kubernetes version
make docker_build KUBE_VERSION=1.33.2

# Build for all supported versions
make docker_build_all

# Test the built image
make docker_test KUBE_VERSION=1.33.2

# Run security scan
make security_scan KUBE_VERSION=1.33.2
```
