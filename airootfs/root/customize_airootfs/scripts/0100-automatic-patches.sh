#!/bin/bash
set -eu

# automatic patches
pushd "automatic"
  # remove git dependency
  sed -i '/installer.check_modified_files()/d' launch.py
  sed -i '/installer.install_submodules()/d' launch.py
  sed -i '/installer.update_wiki()/d' launch.py
  sed -i 's/installer.check_timestamp()/False/g' launch.py

  # remove internet dependency
  sed -i '/installer.check_version()/d' launch.py
  sed -i 's/lambda: {"choices": theme.list_themes()}, refresh=theme.refresh_themes/{"choices": ["black-teal"]}/g' modules/shared.py
  sed -i 's/shared.opts.motd/False/g' modules/api/api.py

  # drop pstate in idle
  patch -p1 < "$CUSTOMIZE_AIROOTFS/patches/0000-automatic-drop-pstate-in-idle.patch"

  # copy config
  cp "$CUSTOMIZE_AIROOTFS/files/automatic-config.json" "config.json"
popd
