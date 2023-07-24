#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

rm /data/swap/swapfile.log

sysctl vm.swappiness=75

echo "-------------------" >> /data/swap/swapfile.log

now=$(date)

echo "$now" >> /data/swap/swapfile.log

OVER_ZRAM_PRIOR="$(cat /data/swap/OVER_ZRAM_PRIOR)"

if [[ "$OVER_ZRAM_PRIOR" -eq 1 ]]; then
    /system/bin/swapon -p 0 /data/swap/swapfile >> /data/swap/swapfile.log
else
    /system/bin/swapon /data/swap/swapfile >> /data/swap/swapfile.log
fi