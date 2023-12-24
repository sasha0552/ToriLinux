#!/bin/bash
set -eu

# automatic dependencies
pushd "automatic"
  # disable package caching
  export PIP_NO_CACHE_DIR=0

  # create venv
  python3 -m venv venv

  # activate venv
  source venv/bin/activate
    # install dependencies
    python3 launch.py --test
  source venv/bin/deactivate
popd
