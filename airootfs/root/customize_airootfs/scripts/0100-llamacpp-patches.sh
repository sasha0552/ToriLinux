#!/bin/bash
set -eu

# llama.cpp patches
pushd "llama.cpp"
  # enable prompt cache by default
  patch -p1 < "$CUSTOMIZE_AIROOTFS/patches/0100-llamacpp-enable-prompt-cache.patch"
popd
