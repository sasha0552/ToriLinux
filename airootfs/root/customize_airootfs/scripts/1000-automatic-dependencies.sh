#!/bin/bash
set -eu

# automatic dependencies
pushd "automatic"
  # create venv
  python3 -m venv venv

  # activate venv
  source venv/bin/activate

  # disable package caching
  export PIP_NO_CACHE_DIR=0

  # install dependencies
  python3 launch.py --test
popd
