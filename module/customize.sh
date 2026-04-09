MODID=lin_os_swap_mod
AUTOMOUNT=true
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true

# # Installation script
chmod 0755 $MODPATH/*

# Setting permissions
set_perm_recursive $MODPATH 0 0 0755 0644

# Load utility functions
. $MODPATH/vars.sh || abort

# Read version from module.prop
SWAP_MOD_VERSION="$(grep '^version=' "$MODPATH/module.prop" | cut -d= -f2)"

# Create Swapfile
create_swapfile(){
    # Check available disk space before creating swap file
    AVAILABLE_KB=$(df /data | tail -1 | awk '{print $4}')
    REQUIRED_KB=$((SWAP_BIN_SIZE * 1024))
    # Keep 512MB headroom so /data doesn't fill completely
    HEADROOM_KB=$((512 * 1024))
    if [ "$AVAILABLE_KB" -lt "$((REQUIRED_KB + HEADROOM_KB))" ]; then
        AVAILABLE_MB=$((AVAILABLE_KB / 1024))
        abort "Not enough space on /data. Need $((SWAP_BIN_SIZE + 512))MB free, only ${AVAILABLE_MB}MB available."
    fi

    ui_print "- Trying to stop Existing Swapfile"
    ui_print "  (This can take a long time, do not panic if it looks stuck)"
    swapoff /data/swap/swapfile 2>/dev/null || true
    ui_print "- [OK]"
    rm -rf /data/swap
    mkdir -p /data/swap
    ui_print "- Creating a swapfile of $SWAP_BIN_SIZE MB"
    ui_print "  This can take a minute or two..."
    dd if=/dev/zero of=/data/swap/swapfile bs=1048576 count="$SWAP_BIN_SIZE"
    ui_print "- [OK]"
    ui_print "- Making Swapfile..."
    mkswap /data/swap/swapfile
    ui_print "- [OK]"
}

# Enable Swapfile settings
enable_swapfile(){
    ui_print "- Setting Swappiness to $SWAPPINESS"
    sysctl vm.swappiness="$SWAPPINESS"
    echo "$SWAP_FILE_PRIOR" > /data/swap/SWAP_FILE_PRIOR
    echo "$SWAPPINESS" > /data/swap/SWAPPINESS
    ui_print "- Now Reboot and see if it works!!"
}

# Start install
custom_install() {
    ui_print "- Please keep the screen on during installation"
    ui_print "- Version $SWAP_MOD_VERSION"
    ui_print "- SWAP-SIZE: $SWAP_BIN_SIZE (MB)"
    ui_print "- SWAPPINESS: $SWAPPINESS"
    ui_print "- SWAP_FILE_PRIOR: $SWAP_FILE_PRIOR"
    create_swapfile
    enable_swapfile
}

#
# # Custom installation
custom_install
