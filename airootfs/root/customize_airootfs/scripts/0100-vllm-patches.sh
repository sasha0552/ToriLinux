#!/bin/bash
set -eu

# vllm patches
pushd "vllm"
  # enable other architectures
  patch -p1 < "$CUSTOMIZE_AIROOTFS/patches/0100-vllm-enable-other-archs.patch"
popd
