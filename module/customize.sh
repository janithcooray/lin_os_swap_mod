MODID=lin_os_swap_mod
AUTOMOUNT=true
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true

# # Installation script
chmod 0755 $MODPATH/*

#check if files are copied
if [ ! -f $MODPATH/addon/keycheck ]; then
    abort "   Files not copied!"
fi

# Setting permisions
set_perm_recursive $MODPATH 0 0 0755 0644

# Load utility functions
. $MODPATH/util.sh || abort
. $MODPATH/vars.sh || abort


function ask_install(){
    ui_print "  Select the Swap File size"
    ui_print "   Vol Up += 8GB"
    ui_print "   Vol Down += 4GB"
    if $VKSEL; then
        ui_print "  Using 8GB"
        SWAP_BIN_SIZE=8192
    else
        ui_print "  Using 4GB"
        SWAP_BIN_SIZE=4096
    fi
}

function create_swapfile(){
    ui_print "- Trying to stop Existing Swapfile"
    swapoff /data/swap/swapfile
    rm -rf /data/swap
    mkdir /data/swap
    ui_print "- Crating a swpafile of $SWAP_BIN_SIZE MB"
    ui_print "  This can take a minute or two"
    cd /data/swap && dd if=/dev/zero of=swapfile bs=1048576 count=$SWAP_BIN_SIZE
    ui_print "- Empty File for Swap of size $SWAP_BIN_SIZE MB Created!!"
    cd /data/swap && mkswap swapfile
    ui_print "- Making Swapfile!!!"
}

function enable_swapfile(){
    ui_print "- Setting Swappiness to 75"
    sysctl vm.swappiness=75
    ui_print "- Now Reboot and see if it works!!"
}


function custom_install() {
    ui_print "- Testing Volume keys... (10 Second timeout)"
    if keytest; then
        ui_print "- Using chooseport method for Volume keys"
        VKSEL=chooseport
        ask_install
    else
        ui_print "- Unable to detect Keys!"
        ui_print "- Using Default $SWAP_BIN_SIZE MB, if you want to change this,"
        ui_print "  Unzip this module, and edit the file vars.sh"
        ui_print "  and change the value of 'SWAP_BIN_SIZE'='xxxx'(MB)"
        ui_print "  zip the file and flash again"
    fi
    create_swapfile
    enable_swapfile
}

#
# # Custom installation
custom_install