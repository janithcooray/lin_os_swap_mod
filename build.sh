#!/bin/sh

set -eu

rm -f module.zip
rm -f lin_os_swap_mod.zip
rm -f swapfile_mod.zip

(cd module && zip -r ../module.zip .)

cp module.zip lin_os_swap_mod.zip
cp module.zip swapfile_mod.zip
