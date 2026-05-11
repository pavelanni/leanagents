#!/usr/bin/env bash

set -euo pipefail

build_temp_dir=""

cleanup() {
  if [[ -n "${build_temp_dir:-}" && -d "${build_temp_dir}" ]]; then
    rm -rf "${build_temp_dir}"
  fi
}

trap cleanup EXIT SIGINT SIGTERM

main() {
  GO_VERSION=1.26.3
  HUGO_VERSION=0.161.1

  export TZ=UTC

  build_temp_dir=$(mktemp -d)
  pushd "${build_temp_dir}" > /dev/null

  mkdir -p "${HOME}/.local"

  echo "Installing Go ${GO_VERSION}..."
  curl -sLJO "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
  tar -C "${HOME}/.local" -xf "go${GO_VERSION}.linux-amd64.tar.gz"
  export PATH="${HOME}/.local/go/bin:${PATH}"

  echo "Installing Hugo ${HUGO_VERSION}..."
  curl -sLJO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
  mkdir -p "${HOME}/.local/hugo"
  tar -C "${HOME}/.local/hugo" -xf "hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
  export PATH="${HOME}/.local/hugo:${PATH}"

  popd > /dev/null

  echo "Go: $(go version)"
  echo "Hugo: $(hugo version)"

  git config core.quotepath false
  if [ "$(git rev-parse --is-shallow-repository)" = "true" ]; then
    git fetch --unshallow
  fi

  echo "Building the site..."
  hugo --gc --minify
}

main "$@"
