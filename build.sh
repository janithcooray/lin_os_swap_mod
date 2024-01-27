#! /bin/zsh
rm -f module.zip
rm -f lin_os_swap_mod.zip
rm -f swapfile_mod.zip
7z a module.zip module/.
cp module.zip lin_os_swap_mod.zip
cp module.zip swapfile_mod.zip
