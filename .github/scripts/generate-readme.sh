#!/bin/bash
export KUBE_VERSIONS=$(tr -d '\r' < .env | grep KUBERNETES_VERSIONS | sed 's/KUBERNETES_VERSIONS=\[//' | sed 's/\]//' | tr -d '"')
export KUBE_LIST=$(echo $KUBE_VERSIONS | tr ',' '\n' | sed 's/^ *//' | sed 's/^/- `/' | sed 's/$/`/')
export LATEST_KUBE_VERSION=$(echo $KUBE_VERSIONS | tr ',' '\n' | sed 's/^ *//' | tail -1)

while IFS= read -r line || [ -n "$line" ]; do
    if [[ "$line" =~ ^[^#]+$ ]]; then
        var_name=$(echo "$line" | cut -d '=' -f 1)
        var_value=$(echo "$line" | cut -d '=' -f 2- | tr -d '\n')
        export "$var_name=$var_value"
    fi
done < .env

envsubst '$KUBE_LIST $LATEST_KUBE_VERSION $ALPINE_VERSION $HELM_VERSION $AWS_CLI_VERSION $SOPS_VERSION $HELM_SECRETS_VERSION $HELM_S3_VERSION $HELM_DIFF_VERSION $HELMFILE_VERSION' \
          < .github/templates/README.md.tpl > README.md
