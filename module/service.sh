#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

echo "-------------------" >> /data/swap/swapfile.log
now=$(date)
echo "$now" >> /data/swap/swapfile.log

# START BOOT SAFETY
# We create a file before swap on and delete it after successful start
# If the file exists on service boot, that means there has been an issue from the 
# Module. Ask the user to share the /data/swap/swapfile.log file with devs

if [ -e "/data/swap/INCOMPLETE" ]; then
    echo "$now : INCOMPLETE FILE still exists! Did it Fail to boot?" >> /data/swap/swapfile.log
else
    echo "INCOMPLETE" >> /data/swap/INCOMPLETE
    SWAP_FILE_PRIOR="$(cat /data/swap/SWAP_FILE_PRIOR)"
    SWAPPINESS="$(cat /data/swap/SWAPPINESS)"
    sysctl vm.swappiness=99
    if [[ "$SWAP_FILE_PRIOR" -eq 0 ]]; then
        /system/bin/swapon /data/swap/swapfile >> /data/swap/swapfile.log
    else
        /system/bin/swapon -p $SWAP_FILE_PRIOR /data/swap/swapfile >> /data/swap/swapfile.log
    fi
fi
# Service BOOT OK!
rm /data/swap/INCOMPLETE