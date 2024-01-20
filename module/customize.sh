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

# Setting permissions
set_perm_recursive $MODPATH 0 0 0755 0644

# Load utility functions
. $MODPATH/util.sh || abort
. $MODPATH/vars.sh || abort

# Option - Select 8GB or 4GB
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

# Option - Select Swap Priority
function ask_zram_prior(){
    ui_print "  Set Swap Priority above Zram?"
    ui_print "   Vol Up += Yes"
    ui_print "   Vol Down += No "
    if $VKSEL; then
        ui_print "  Setting to 0"
        OVER_ZRAM_PRIOR=1
    else
        ui_print "  Setting to auto"
        OVER_ZRAM_PRIOR=0
    fi
}

# Create Swapfile
function create_swapfile(){
    ui_print "- Trying to stop Existing Swapfile"
    ui_print "  (This can take a few minutes, do not panic if it looks stuck)"
    swapoff /data/swap/swapfile
    rm -rf /data/swap
    mkdir /data/swap
    ui_print "- Crating a swapfile of $SWAP_BIN_SIZE MB"
    ui_print "  This can take a minute or two"
    cd /data/swap && dd if=/dev/zero of=swapfile bs=1048576 count=$SWAP_BIN_SIZE
    ui_print "- Empty File for Swap of size $SWAP_BIN_SIZE MB Created!!"
    cd /data/swap && mkswap swapfile
    ui_print "- Making Swapfile!!!"
}

# Enable Swapfile settings
function enable_swapfile(){
    ui_print "- Setting Swappiness to 99"
    sysctl vm.swappiness=75
    echo $OVER_ZRAM_PRIOR > /data/swap/OVER_ZRAM_PRIOR
    ui_print "- Now Reboot and see if it works!!"
}

# Start install
function custom_install() {
    ui_print "- Please keep the screen on during installation"
    ui_print "- Version 1.3"
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
        ui_print "  Using Default Swap Priority - auto"
    fi
    create_swapfile
    ask_zram_prior
    enable_swapfile
}

#
# # Custom installation
custom_install
