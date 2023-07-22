#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

#!/system/sbin/sh
# vm_swap_ratio=100 is default, no need to set
#sysctl vm.swap_ratio_enable=1
rm /data/swap/swapfile.log
sysctl vm.swappiness=75
echo "-------------------" >> /data/swap/swapfile.log
now=$(date)
echo "$now" >> /data/swap/swapfile.log
/system/bin/swapon /data/swap/swapfile >> /data/swap/swapfile.log