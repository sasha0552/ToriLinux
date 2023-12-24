#!/bin/bash
set -eu

# stable-diffusion-webui dependencies
pushd "stable-diffusion-webui"
  # disable package caching
  export PIP_NO_CACHE_DIR=0

  # create venv
  python3 -m venv venv

  # activate venv
  source venv/bin/activate
    # install dependencies
    pip3 install -r requirements.txt
  source venv/bin/deactivate
popd
