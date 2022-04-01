#!/bin/bash
set -e -o pipefail

export MODULE_NAME="${1}"
export ENV="${2}"
export REGION="${3:-us-east-2}"

cd "$(dirname "${0}")/module/aws/commands" || true
source pre.sh
cd "../${MODULE_NAME}" || true

# Run Terragrunt Infrastructure
echo "Running Terragrunt for environment: ${ENV}"

terragrunt init ${TFTG_CLI_ARGS_INIT_MODULE}