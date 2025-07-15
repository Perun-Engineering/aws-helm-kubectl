default: docker_build
include .env

# Latest version of alpine may be found at: https://hub.docker.com/_/alpine
# Latest version of python may be found at: https://hub.docker.com/_/python
# Latest version of kubectl may be found at: https://github.com/kubernetes/kubernetes/releases
# Latest version of helm may be found at: https://github.com/helm/helm/releases
# Latest version of helm-secrets may be found at: https://github.com/jkroepke/helm-secrets/releases
# Latest version of sops may be found at: https://github.com/getsops/sops/releases
# Latest version of aws-cli may be found at: https://github.com/aws/aws-cli/tags
# Latest version of helmfile may be found at: https://github.com/helmfile/helmfile/releases
# Latest version of helm-s3 may be found at: https://github.com/hypnoglow/helm-s3/releases
# Latest version of helm-diff may be found at: https://github.com/databus23/helm-diff/releases

DOCKER_IMAGE ?= sirantd/aws-helm-kubectl
GHCR_IMAGE ?= ghcr.io/perun-engineering/aws-helm-kubectl
DOCKER_TAG ?= `git rev-parse --abbrev-ref HEAD`
KUBE_VERSION ?= 1.32.1

.PHONY: help docker_build docker_push docker_test security_scan clean validate_versions generate_readme

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \\033[36m%-20s\\033[0m %s\\n", $$1, $$2}'

docker_build: ## Build Docker image
	@echo "Building Docker image with Kubernetes version: $(KUBE_VERSION)"
	@docker buildx build \
	  --build-arg KUBE_VERSION=${KUBE_VERSION} \
	  --build-arg HELM_VERSION=${HELM_VERSION} \
	  --build-arg SOPS_VERSION=${SOPS_VERSION} \
	  --build-arg HELM_SECRETS_VERSION=${HELM_SECRETS_VERSION} \
	  --build-arg HELM_S3_VERSION=${HELM_S3_VERSION} \
	  --build-arg HELMFILE_VERSION=${HELMFILE_VERSION} \
	  --build-arg AWS_CLI_VERSION=${AWS_CLI_VERSION} \
	  --build-arg HELM_DIFF_VERSION=${HELM_DIFF_VERSION} \
      --build-arg ALPINE_PYTHON=${ALPINE_PYTHON} \
      --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
	  -t ${DOCKER_IMAGE}:${KUBE_VERSION} .

docker_build_all: ## Build Docker images for all Kubernetes versions
	@echo "Building Docker images for all Kubernetes versions..."
	@for version in $(shell echo '${KUBERNETES_VERSIONS}' | jq -r '.[]'); do \
		echo "Building for Kubernetes version: $$version"; \
		make docker_build KUBE_VERSION=$$version; \
	done

docker_push: ## Push Docker image to registry
	@echo "Pushing Docker image: ${DOCKER_IMAGE}:${KUBE_VERSION}"
	docker push $(DOCKER_IMAGE):$(KUBE_VERSION)

docker_push_all: ## Push all Docker images to registry
	@echo "Pushing all Docker images..."
	@for version in $(shell echo '${KUBERNETES_VERSIONS}' | jq -r '.[]'); do \
		echo "Pushing Docker image: ${DOCKER_IMAGE}:$$version"; \
		docker push ${DOCKER_IMAGE}:$$version; \
	done

docker_test: ## Test Docker image functionality
	@echo "Testing Docker image: ${DOCKER_IMAGE}:${KUBE_VERSION}"
	@docker run --rm ${DOCKER_IMAGE}:${KUBE_VERSION} /bin/bash -c "\
		echo 'Testing tool versions:' && \
		kubectl version --client && \
		helm version && \
		aws --version && \
		sops --version && \
		helmfile --version && \
		echo 'All tools working correctly!'"

security_scan: ## Run security scan on Docker image
	@echo "Running security scan on: ${DOCKER_IMAGE}:${KUBE_VERSION}"
	@if command -v trivy >/dev/null 2>&1; then \
		trivy image --severity HIGH,CRITICAL ${DOCKER_IMAGE}:${KUBE_VERSION}; \
	else \
		echo "Trivy not installed. Install with: brew install trivy (macOS) or apt-get install trivy (Ubuntu)"; \
	fi

validate_versions: ## Validate that all version variables are set
	@echo "Validating version variables..."
	@echo "Alpine Python: ${ALPINE_PYTHON}"
	@echo "Alpine Version: ${ALPINE_VERSION}"
	@echo "Kubernetes Versions: ${KUBERNETES_VERSIONS}"
	@echo "Helm Version: ${HELM_VERSION}"
	@echo "SOPS Version: ${SOPS_VERSION}"
	@echo "Helm Secrets Version: ${HELM_SECRETS_VERSION}"
	@echo "Helm S3 Version: ${HELM_S3_VERSION}"
	@echo "Helmfile Version: ${HELMFILE_VERSION}"
	@echo "AWS CLI Version: ${AWS_CLI_VERSION}"
	@echo "Helm Diff Version: ${HELM_DIFF_VERSION}"
	@echo "All versions validated!"

generate_readme: ## Generate README.md from template
	@echo "Generating README.md..."
	@./.github/scripts/generate-readme.sh
	@echo "README.md generated successfully!"

clean: ## Clean up Docker images and containers
	@echo "Cleaning up Docker images..."
	@docker system prune -f
	@docker images | grep "${DOCKER_IMAGE}" | awk '{print $$3}' | xargs -r docker rmi -f

dev_shell: ## Run interactive shell in the Docker image
	@echo "Starting interactive shell in: ${DOCKER_IMAGE}:${KUBE_VERSION}"
	@docker run -it --rm -v $(PWD):/workspace ${DOCKER_IMAGE}:${KUBE_VERSION} /bin/bash
