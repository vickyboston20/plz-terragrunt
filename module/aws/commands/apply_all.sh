#!/bin/bash
set -e -o pipefail

export ENV="${1}"
export REGION="${2:-us-east-2}"

cd "$(dirname "${0}")/module/aws/commands" || true
source pre.sh
cd "../${MODULE_NAME}" || true

# Run Terragrunt Infrastructure
echo "Running Terragrunt for environment: ${ENV}"

terragrunt run-all apply ${TFTG_CLI_ARGS_APPLY_ALL}