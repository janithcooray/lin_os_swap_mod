#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

echo "----------BOOT---------" >> $SWAP_FILE_PATH/swapfile.log
function print_log(){
    now=$(date)
    echo "$now : $1 $2" >> $SWAP_FILE_PATH/swapfile.log
}

function check_file(){
        print_log "Checking if $1 Exists"
    if [ -e $1 ]; then
        print_log "File exists."
    else
        print_log "File does not exist."
    fi
}

function check_bin(){
    if command -v $1 >/dev/null 2>&1; then
        print_log "$1 exists."
    else
        print_log "$1 does not exist."
    fi
}

# START BOOT SAFETY
# We create a file before swap on and delete it after successful start
# If the file exists on service boot, that means there has been an issue from the 
# Module. Ask the user to share the $SWAP_FILE_PATH/swapfile.log file with devs
check_file "/system/bin/swapon"
check_bin "swapon"
check_bin "sysctl"
check_bin "whereis"

if [ -e "$SWAP_FILE_PATH/INCOMPLETE" ]; then
    print_log "Swap is disabled sue to fail safe mode. A previous session falied to start. Remove $SWAP_FILE_PATH/INCOMPLETE and reboot to disable."
else
    echo "INCOMPLETE" >> $SWAP_FILE_PATH/INCOMPLETE
    print_log "Preparing to start.."
    SWAP_FILE_PRIOR="$(cat $SWAP_FILE_PATH/SWAP_FILE_PRIOR)"
    SWAPPINESS="$(cat $SWAP_FILE_PATH/SWAPPINESS)"
    print_log "setting swappiness.."
    sysctl vm.swappiness=$SWAPPINESS
    # At this point if it fails, it will exit the script leaving $SWAP_FILE_PATH/INCOMPLETE
    print_log "[OK] setting swappiness.."
    if [[ "$SWAP_FILE_PRIOR" -eq 0 ]]; then
        print_log "Starting swap with auto priority"
        swapon $SWAP_FILE_PATH/swapfile >> $SWAP_FILE_PATH/swapfile.log
        print_log "No Errors Reported"
    else
        print_log "Starting swap with $SWAP_FILE_PRIOR priority"
        swapon -p $SWAP_FILE_PRIOR $SWAP_FILE_PATH/swapfile >> $SWAP_FILE_PATH/swapfile.log
        print_log "No Errors Reported"
    fi
fi
FREE_M="$(free -h)"
print_log "Free Mem - " $FREE_M
# Service BOOT OK!
rm $SWAP_FILE_PATH/INCOMPLETE
