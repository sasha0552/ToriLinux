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
    pip3 install packaging wheel

    # install flash-attn without build isolation
    cat requirements.txt | grep flash-attn | xargs pip3 install --no-build-isolation

    # install axolotl
    pip3 install -e ".[flash-attn,deepspeed]"
  deactivate
popd
