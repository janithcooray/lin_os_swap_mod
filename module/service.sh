#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

echo "----------BOOT---------" >> /data/swap/swapfile.log
function print_log(){
    now=$(date)
    echo "$now : $1 - $2" >> /data/swap/swapfile.log
}

function check_file(){
        print_log "Checking if $1 Exists"
    if [ -e $1 ]; then
        echo "File exists."
    else
        echo "File does not exist."
    fi
}

function check_bin(){
    if command -v $1 >/dev/null 2>&1; then
        echo "$1 exists."
    else
        echo "$1 does not exist."
    fi
}

# START BOOT SAFETY
# We create a file before swap on and delete it after successful start
# If the file exists on service boot, that means there has been an issue from the 
# Module. Ask the user to share the /data/swap/swapfile.log file with devs
check_file "/system/bin/swapon"
check_bin "swapon"
check_bin "sysctl"

if [ -e "/data/swap/INCOMPLETE" ]; then
    echo "$now : INCOMPLETE FILE still exists! Did it Fail to boot?" >> /data/swap/swapfile.log
else
    echo "INCOMPLETE" >> /data/swap/INCOMPLETE
    SWAP_FILE_PRIOR="$(cat /data/swap/SWAP_FILE_PRIOR)"
    SWAPPINESS="$(cat /data/swap/SWAPPINESS)"
    sysctl vm.swappiness=$SWAPPINESS
    # At this point if it fails, it will exit the script leaving /data/swap/INCOMPLETE
    if [[ "$SWAP_FILE_PRIOR" -eq 0 ]]; then
        /system/bin/swapon /data/swap/swapfile >> /data/swap/swapfile.log
    else
        /system/bin/swapon -p $SWAP_FILE_PRIOR /data/swap/swapfile >> /data/swap/swapfile.log
    fi
fi
# Service BOOT OK!
rm /data/swap/INCOMPLETE