TMP_PATH="/tmp/homelab"

clean-tmp() {
    if ! [ -d "$TMP_PATH" ]; then
        return
    fi
    
    # Be able to delete everything
    chmod -R u+w "$TMP_PATH"
    rm -rf "$TMP_PATH"
}

export TMP_PATH
