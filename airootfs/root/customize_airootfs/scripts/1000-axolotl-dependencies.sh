#!/bin/bash
set -eu

# axolotl dependencies
pushd "axolotl"
  # disable package caching
  export PIP_NO_CACHE_DIR=0

  # create venv
  python3 -m venv venv

  # activate venv
  source venv/bin/activate
    # install dependencies
    pip3 install packaging
    pip3 install -e ".[flash-attn,deepspeed]"
  deactivate
popd
