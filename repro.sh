#!/usr/bin/env bash
# Runs the shim pnpm wrote for tool-pkg's tool.cmd in each MSYS argument conversion mode.
set -u

run() {
  echo "\$ $*"
  "$@" < /dev/null 2>&1 | tr -d '\000\r'
  echo
}

echo "pnpm $(pnpm --version), $(uname -s)"
run env -u MSYS_NO_PATHCONV -u MSYS2_ARG_CONV_EXCL sh node_modules/.bin/tool hello /usr
run env MSYS_NO_PATHCONV=1 sh node_modules/.bin/tool hello /usr
run env 'MSYS2_ARG_CONV_EXCL=*' sh node_modules/.bin/tool hello /usr
