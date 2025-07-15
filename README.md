# AWS Helm Kubectl Docker Image

Multi-architecture Docker image containing AWS CLI, Helm, Kubectl, and other commonly used Kubernetes tools.

## Supported Architectures

- `linux/amd64`
- `linux/arm64`

## Available Tags (Kubectl Versions)

- `1.30.14`
- `1.31.10`
- `1.32.6`
- `1.33.2`

## Components Versions

All current images include the following tools:

| Component | Version |
|-----------|---------|
| Alpine | 3.22.0 |
| Helm | 3.18.4 |
| AWS CLI | 2.27.50 |
| SOPS | 3.10.2 |
| Helm Secrets Plugin | 4.6.5 |
| Helm S3 Plugin | 0.17.0 |
| Helm Diff Plugin | 3.12.3 |
| Helmfile | 1.1.3 |

## Usage

Pull the specific kubectl version you need:
```bash
docker pull sirantd/aws-helm-kubectl:1.33.2
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
  sirantd/aws-helm-kubectl:1.33.2 \
  kubectl get nodes
```

### Mount kubeconfig
```bash
# Mount your kubeconfig file
docker run --rm -it \
  -v ~/.kube:/home/appuser/.kube:ro \
  sirantd/aws-helm-kubectl:1.33.2 \
  kubectl get pods
```

### Interactive Shell
```bash
# Start an interactive shell
docker run --rm -it \
  -v $(pwd):/workspace \
  sirantd/aws-helm-kubectl:1.33.2 \
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
