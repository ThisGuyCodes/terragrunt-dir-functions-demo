#!/usr/bin/env bash
set -euo pipefail

_repo_root() {
    git rev-parse --show-toplevel
}

main() {
    cd "$(_repo_root)/terragrunt/deployments/thing"
    terragrunt render-json --terragrunt-json-out /dev/stdout |
        jq .locals
}

main "$@"
