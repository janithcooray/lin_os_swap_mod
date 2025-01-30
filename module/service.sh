#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

echo "-------------------" >> $SWAP_FILE_PATH/swapfile.log
now=$(date)
echo "$now" >> $SWAP_FILE_PATH/swapfile.log

# START BOOT SAFETY
# We create a file before swap on and delete it after successful start
# If the file exists on service boot, that means there has been an issue from the 
# Module. Ask the user to share the $SWAP_FILE_PATH/swapfile.log file with devs

if [ -e "$SWAP_FILE_PATH/INCOMPLETE" ]; then
    echo "$now : INCOMPLETE FILE still exists! Did it Fail to boot?" >> $SWAP_FILE_PATH/swapfile.log
else
    echo "INCOMPLETE" >> $SWAP_FILE_PATH/INCOMPLETE
    SWAP_FILE_PRIOR="$(cat $SWAP_FILE_PATH/SWAP_FILE_PRIOR)"
    SWAPPINESS="$(cat $SWAP_FILE_PATH/SWAPPINESS)"
    sysctl vm.swappiness=99
    if [[ "$SWAP_FILE_PRIOR" -eq 0 ]]; then
        /system/bin/swapon $SWAP_FILE_PATH/swapfile >> $SWAP_FILE_PATH/swapfile.log
    else
        /system/bin/swapon -p $SWAP_FILE_PRIOR $SWAP_FILE_PATH/swapfile >> $SWAP_FILE_PATH/swapfile.log
    fi
fi
# Service BOOT OK!
rm $SWAP_FILE_PATH/INCOMPLETE
