#!/usr/bin/env bash

#set -euo pipefail

TMP_PATH="/tmp/homelab"

clean_tmp() {
    if ! [ -d "$TMP_PATH" ]; then
        return
    fi
    
    # Be able to delete everything
    chmod -R u+w "$TMP_PATH"
    rm -rf "$TMP_PATH"
}

INITIAL_CWD="$(pwd)"
SCRIPT_DIR_PATH="$(dirname "$0")"

cd "$SCRIPT_DIR_PATH" || exit

ISO_FILE=$1
PUB_KEY_FILE=$2

if [ "$ISO_FILE" == "" ]; then
    echo "Provide a Debian installation ISO file"
    exit 1
fi

if ! [ -f "$ISO_FILE" ]; then
    echo "The given Debian installation ISO file does not exist"
    exit 1
fi

if [ "$PUB_KEY_FILE" == "" ]; then
    echo "Provide a public key for authentication"
    exit 1
fi

if ! [ -f "$PUB_KEY_FILE" ]; then
    echo "The given public authentication file does not exist"
    exit 1
fi

clean_tmp

TMP_ISO_PATH="$TMP_PATH/debian/iso"
mkdir -p "$TMP_ISO_PATH"

xorriso -osirrox on -indev "$ISO_FILE" -extract / "$TMP_ISO_PATH"

ISO_INSTALL_DIR="install.amd"
TMP_ISO_INSTALL_PATH="$TMP_ISO_PATH/$ISO_INSTALL_DIR"

# Add preseed.cfg to initrd
chmod +w -R "$TMP_ISO_INSTALL_PATH"

gunzip "$TMP_ISO_INSTALL_PATH/initrd.gz"
echo ./preseed.cfg | cpio -H newc -o -A -F "$TMP_ISO_INSTALL_PATH/initrd"
gzip "$TMP_ISO_INSTALL_PATH/initrd"

chmod -w -R "$TMP_ISO_INSTALL_PATH/"

# Regenerate md5sum.txt
cd "$TMP_ISO_PATH" || exit

chmod +w md5sum.txt

# The warning about ""./debian" is ok as it is a symlink to "."
find . -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > md5sum.txt

chmod -w md5sum.txt

# Add SSH public key
chmod +w "$TMP_ISO_PATH"

cat "$PUB_KEY_FILE" >> "$TMP_ISO_PATH/authorized_keys"

chmod -w "$TMP_ISO_PATH"

# Build final ISO
cd "$INITIAL_CWD" || exit

rm -f ./patched.iso

xorriso \
   -indev "$ISO_FILE" \
   -outdev ./patched.iso \
   \
   -map "$TMP_ISO_INSTALL_PATH" "/$ISO_INSTALL_DIR" \
   -map "$TMP_ISO_PATH/md5sum.txt" /md5sum.txt \
   -map "$TMP_ISO_PATH/authorized_keys" /authorized_keys \
   \
   -boot_image any replay \
   \
   -compliance no_emul_toc \
   -padding included

clean_tmp