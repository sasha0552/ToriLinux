#!/bin/sh
set -eu

# Apply patch to archiso
patch -d/ -p0 << 'EOF'
--- /usr/bin/mkarchiso
+++ /usr/bin/mkarchiso
@@ -1212,6 +1212,10 @@

 # Build airootfs filesystem image
 _prepare_airootfs_image() {
+    _msg_info 'Deduping files in the pacstrap directory...'
+    rdfind -checksum sha256 -makehardlinks true "${pacstrap_dir:?}/"
+    _msg_info 'Done!'
+
     _run_once "_mkairootfs_${airootfs_image_type}"
     _mkchecksum

@@ -1227,6 +1231,10 @@
     if [[ -v cert_list ]]; then
         _cms_sign_artifact "${airootfs_image_filename}"
     fi
+
+    _msg_info 'Removing the pacstrap directory...'
+    rm -rf -- "${pacstrap_dir:?}/"
+    _msg_info 'Done!'
 }

 # export build artifacts for netboot
EOF
