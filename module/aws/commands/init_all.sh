#!/bin/bash
set -e -o pipefail

export ENV="${1}"
export REGION="${2:-us-east-2}"

cd "$(dirname "${0}")/module/aws/commands" || true
source pre.sh
cd ".."

# Run Terragrunt Infrastructure
echo "Running Terragrunt for environment: ${ENV}"

terragrunt init ${TFTG_CLI_ARGS_INIT_ALL}