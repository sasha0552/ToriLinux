#!/bin/bash
set -eu

# SillyTavern-Extras dependencies
pushd "SillyTavern-Extras"
  # disable package caching
  export PIP_NO_CACHE_DIR=0

  # create venv
  python3 -m venv venv

  # activate venv
  source venv/bin/activate
    # install dependencies
    pip3 install -r requirements.txt
    pip3 install -r requirements-coqui.txt
    pip3 install -r requirements-rvc.txt
  deactivate
popd
