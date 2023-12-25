#!/bin/bash
set -eu

# automatic cleanup
pushd "automatic"
  # remove installation config
  rm config.json

  # remove installation log
  rm sdnext.log
popd
