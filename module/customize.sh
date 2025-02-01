function getProperty {
   PROP_KEY=$1
   PROP_VALUE=`cat "${PROPERTY_FILE}" | grep -w "$PROP_KEY" | cut -d '=' -f 2 | tr -d '\n\r'`
   echo $PROP_VALUE
}

PROPERTY_FILE=$MODPATH/module.prop
MODID=$(getProperty "id")
AUTOMOUNT=true
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true
SWAP_MOD_VERSION=$(getProperty "version")

# # Installation script
chmod 0755 $MODPATH/*

# Setting permissions
set_perm_recursive $MODPATH 0 0 0755 0644

# Load utility functions
. $MODPATH/vars.sh || abort

# Create Swapfile
function create_swapfile(){
    ui_print "- Trying to stop Existing Swapfile"
    ui_print "  (This can take a long time, do not panic if it looks stuck)"
    swapoff /data/swap/swapfile
    ui_print "- [OK]"
    rm -rf /data/swap
    mkdir /data/swap
    ui_print "- Creating a swapfile of $SWAP_BIN_SIZE MB"
    ui_print "  This can take a minute or two..."
    cd /data/swap && dd if=/dev/zero of=swapfile bs=1048576 count=$SWAP_BIN_SIZE
    ui_print "- [OK]"
    ui_print "- Making Swapfile..."
    cd /data/swap && mkswap swapfile
    ui_print "- [OK]"
}

# Enable Swapfile settings
function enable_swapfile(){
    ui_print "- Setting Swappiness to $SWAPPINESS"
    sysctl vm.swappiness=$SWAPPINESS
    echo $SWAP_FILE_PRIOR > /data/swap/SWAP_FILE_PRIOR
    echo $SWAPPINESS > /data/swap/SWAPPINESS
    ui_print "- Now Reboot and see if it works!!"
}

# Start install
function custom_install() {
    ui_print "- Please keep the screen on during installation"
    ui_print "- Version $SWAP_MOD_VERSION"
    ui_print "- SWAP-SIZE: $SWAP_BIN_SIZE (MB)"
    ui_print "- SWAPPINESS: $SWAPPINESS"
    ui_print "- SWAP_FILE_PRIOR: $SWAP_FILE_PRIOR"
    create_swapfile
    enable_swapfile
}

#
# # Custom installation
custom_install
