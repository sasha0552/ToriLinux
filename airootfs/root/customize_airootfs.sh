#!/bin/bash
set -eu

# move new os-release to its place
mv /usr/lib/os-release.new /usr/lib/os-release

# set user password
echo "tori:tori" | chpasswd

# remove any jinja2 files
find -type f -name "*.jinja2" -print -delete

# enter user directory
cd "/home/tori"

# customize_airootfs temporary directory
export CUSTOMIZE_AIROOTFS=/root/customize_airootfs

# execute scripts
for script in $CUSTOMIZE_AIROOTFS/scripts/*.sh; do
  # print current script
  echo "===> Executing script $script"

  # add execution permission
  chmod +x "$script"

  # launch script as user
  su tori -c "$script"
done

# remove customize_airootfs temporary directory
rm -r "$CUSTOMIZE_AIROOTFS"
