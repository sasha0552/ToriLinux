#!/bin/bash
set -eu

# axolotl dependencies
pushd "axolotl"
  # disable package caching
  export PIP_NO_CACHE_DIR=0

  # limit the number of parallel jobs to avoid OOM
  export MAX_JOBS=2

  # define supported architectures
  export TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0 7.5 8.0 8.6 8.9 9.0"

  # cuda home directory
  export CUDA_HOME=/opt/cuda

  # use gcc 12
  export CC=gcc-12
  export CXX=g++-12

  # create venv
  python3 -m venv venv

  # activate venv
  source venv/bin/activate
    # install dependencies
    pip3 install packaging torch wheel

    # install flash-attn without build isolation
    cat requirements.txt | grep flash-attn | xargs pip3 install --no-build-isolation

    # install axolotl
    pip3 install -e ".[flash-attn,deepspeed]"
  deactivate
popd
