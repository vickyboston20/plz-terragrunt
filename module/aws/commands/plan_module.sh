#!/bin/bash
set -e -o pipefail

export MODULE_NAME="${1}"
export ENV="${2}"
export REGION="${3:-us-east-2}"

cd "$(dirname "${0}")/module/aws/commands" || true
source pre.sh
source git.sh
cd "../${MODULE_NAME}" || true

# Run Terragrunt Infrastructure
echo "Running Terragrunt for environment: ${ENV}"

terragrunt plan -out=tf-plan.binary ${TFTG_CLI_ARGS_PLAN_MODULE}