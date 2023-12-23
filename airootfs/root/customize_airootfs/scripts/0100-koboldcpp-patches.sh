#!/bin/bash
set -eu

# koboldcpp patches
pushd "koboldcpp"
  # drop pstate in idle
  patch -p1 < "$CUSTOMIZE_AIROOTFS/patches/0000-koboldcpp-drop-pstate-in-idle.patch"
popd
