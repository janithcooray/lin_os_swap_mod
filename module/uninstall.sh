#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# Load utility functions
. $MODDIR/vars.sh || abort

swapoff $SWAP_FILE_PATH/swapfile
rm -rf $SWAP_FILE_PATH
