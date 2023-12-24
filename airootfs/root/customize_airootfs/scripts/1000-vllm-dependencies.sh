#!/bin/bash
set -eu

# vllm dependencies
pushd "vllm"
  # disable package caching
  export PIP_NO_CACHE_DIR=0

  # limit the number of parallel jobs to avoid OOM
  export MAX_JOBS=1

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
    pip3 install -r requirements.txt
    pip3 install -r requirements-build.txt

    # build native extension
    python3 setup.py build_ext --inplace
  source venv/bin/deactivate

  # remove venv
  rm -fr venv

  # create venv
  python3 -m venv venv

  # activate venv
  source venv/bin/activate
    # install dependencies
    pip3 install -r requirements.txt
  source venv/bin/deactivate
popd
