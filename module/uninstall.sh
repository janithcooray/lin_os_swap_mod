[ ! "$MODPATH" ] && MODPATH=${0%/*}

# functions
. $MODPATH/vars.sh

# stop swap and remove directory
if [ "echo $SWAP_FILE_PATH" != "" ]; then
    swapoff $SWAP_FILE_PATH/swapfile
    rm -rf $SWAP_FILE_PATH
fi
