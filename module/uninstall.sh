[ ! "$MODPATH" ] && MODPATH=${0%/*}

# functions
. $MODPATH/functions.sh

# parameters
PARAMETERS=$MODPATH/parameters.prop
SWAP_FILE_PATH=`grep_prop SWAP_FILE_PATH $PARAMETERS`

# stop swap and remove directory
if [ "echo $SWAP_FILE_PATH" != "" ]; then
    swapoff $SWAP_FILE_PATH/swapfile
    rm -rf $SWAP_FILE_PATH
fi
