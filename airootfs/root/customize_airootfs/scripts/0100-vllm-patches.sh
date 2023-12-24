#!/bin/bash
set -eu

# vllm patches
pushd "vllm"
  # build for pascal
  patch -p1 < "$CUSTOMIZE_AIROOTFS/patches/0100-vllm-build-for-pascal.patch"
popd
