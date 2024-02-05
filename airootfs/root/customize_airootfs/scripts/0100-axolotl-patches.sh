#!/bin/bash
set -eu

# axolotl patches
pushd "axolotl"
  # TODO: fix xformers version
  sed -i 's/xformers>=0.0.23/xformers==0.0.23/g' setup.py
popd
