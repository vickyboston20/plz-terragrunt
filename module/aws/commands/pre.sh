#!/bin/bash
set -e -o pipefail

# returns the context of any active subroutine call
function caller_script(){
    caller 1
}

# contains script name that source this script
PARENT_COMMAND_SCRIPT=$(basename $(echo $(caller_script) | cut -d " " -f3 ))

# initial setup and cleaning
function init {
    find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
    find . -type d -name ".terraform" -prune -exec rm -rf {} \;
}

# default commands for the terragrunt cli
DEFAULT_TFTG_CLI_ARGS="-no-color --terragrunt-non-interactive"

function setTfTgCliArguments() {
    export TFTG_CLI_ARGS_APPLY_ALL="${DEFAULT_TFTG_CLI_ARGS} -auto-approve"
    export TFTG_CLI_ARGS_APPLY_MODULE="${DEFAULT_TFTG_CLI_ARGS} -auto-approve"
    export TFTG_CLI_ARGS_DESTROY_ALL="-no-color -auto-approve"
    export TFTG_CLI_ARGS_DESTROY_MODULE="-no-color -auto-approve"
    export TFTG_CLI_ARGS_INIT_ALL="${DEFAULT_TFTG_CLI_ARGS}"
    export TFTG_CLI_ARGS_INIT_MODULE="${DEFAULT_TFTG_CLI_ARGS}"
    export TFTG_CLI_ARGS_OUTPUT_ALL="${DEFAULT_TFTG_CLI_ARGS}"
    export TFTG_CLI_ARGS_OUTPUT_MODULE="${DEFAULT_TFTG_CLI_ARGS}"
    export TFTG_CLI_ARGS_PLAN_ALL="${DEFAULT_TFTG_CLI_ARGS}"
    export TFTG_CLI_ARGS_PLAN_MODULE="${DEFAULT_TFTG_CLI_ARGS}"
}

function set_and_auth() {
    setTfTgCliArguments

    TERRAFORM_VERSION="${TERRAFORM_VERSION:-1.0.11}"
    TERRAGRUNT_VERSION="${TERRAGRUNT_VERSION:-0.36.5}"
    TF_VAR_account_number="${ACCOUNT_NUMBER:-251721600074}"

    echo ""
    echo "[INFO] Environment            : ${ENV}"
    echo "[INFO] Account Id             : ${TF_VAR_account_number}"
    echo "[INFO] Module Name            : ${MODULE_NAME}"
    echo "[INFO] Region                 : ${REGION}"
    echo "[INFO] Terraform Version      : ${TERRAFORM_VERSION}"
    echo "[INFO] Terragrunt Version     : ${TERRAGRUNT_VERSION}"
    echo "[INFO] Executing Directory    : ${PWD}"
    echo ""
    tfswitch "${TERRAFORM_VERSION}"
    tgswitch "${TERRAGRUNT_VERSION}"
}

case "${ENV}" in
    "local")
        set_and_auth
        ;;
    "dev")
        set_and_auth
        ;;
    "test")
        set_and_auth
        ;;
    "prod")
        set_and_auth
        ;;
    *)
    echo "${ENV} is not valid environment. Terminating..."
    exit 1
    ;;
esac
    
