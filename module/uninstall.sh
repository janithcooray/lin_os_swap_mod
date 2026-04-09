#!/system/bin/sh
swapoff /data/swap/swapfile 2>/dev/null || true
rm -rf /data/swap
