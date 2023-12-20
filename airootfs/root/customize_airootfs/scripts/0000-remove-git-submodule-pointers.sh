#!/bin/bash
set -eu

# remove git submodule pointers to the root project
find -type f -name .git -exec rm {} \;
