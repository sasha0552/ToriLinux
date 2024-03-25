#!/bin/bash
set -eu

# vllm patches
pushd "vllm"
  # specify cuda architectures
  patch -p1 < "$CUSTOMIZE_AIROOTFS/patches/0100-vllm-specify-cuda-architecturs.patch"
popd
