[ ! "$MODPATH" ] && MODPATH=${0%/*}

# functions
. $MODPATH/functions.sh

# variables
UID=`id -u`
[ ! "$UID" ] && UID=0
PARAMETERS=/data/media/"$UID"/parameters.prop
if [ ! -f $PARAMETERS ]; then
  echo "# SWAP FILE SIZE [2 - 999999]MB" >> $PARAMETERS
  echo "SWAP_BIN_SIZE=8192" >> $PARAMETERS
  echo "# SWAPPINESS [0 - 100]" >> $PARAMETERS
  echo "SWAPPINESS=99" >> $PARAMETERS
  echo "# SWAP PRIORITY [-999999 - 999999]" >> $PARAMETERS
  echo "# 0 Will make it auto" >> $PARAMETERS
  echo "SWAP_FILE_PRIOR=0" >> $PARAMETERS
  echo "# SWAP FILE PATH" >> $PARAMETERS
  echo "SWAP_FILE_PATH=/data/swap" >> $PARAMETERS
fi
cp -f $PARAMETERS $MODPATH/parameters.prop
PARAMETERS=$MODPATH/parameters.prop

MODID=`grep_prop id $MODPATH/module.prop`
SWAP_MOD_VERSION=`grep_prop version $MODPATH/module.prop`
AUTOMOUNT=true
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=true
SWAP_BIN_SIZE=`grep_prop SWAP_BIN_SIZE $PARAMETERS`
SWAPPINESS=`grep_prop SWAPPINESS $PARAMETERS`
SWAP_FILE_PRIOR=`grep_prop SWAP_FILE_PRIOR $PARAMETERS`
SWAP_FILE_PATH=`grep_prop SWAP_FILE_PATH $PARAMETERS`

# Installation script
chmod 0755 $MODPATH/*

# Setting permissions
set_perm_recursive $MODPATH 0 0 0755 0644

# Create Swapfile
function create_swapfile(){
    ui_print "- Trying to stop Existing Swapfile"
    ui_print "  (This can take a long time, do not panic if it looks stuck)"
    swapoff $SWAP_FILE_PATH/swapfile
    ui_print "- [OK]"
    rm -rf $SWAP_FILE_PATH
    mkdir $SWAP_FILE_PATH
    ui_print "- Creating a swapfile of $SWAP_BIN_SIZE MB"
    ui_print "  This can take a minute or two..."
    cd $SWAP_FILE_PATH && dd if=/dev/zero of=swapfile bs=1048576 count=$SWAP_BIN_SIZE
    ui_print "- [OK]"
    ui_print "- Making Swapfile..."
    cd $SWAP_FILE_PATH && mkswap swapfile
    ui_print "- [OK]"
}

# Enable Swapfile settings
function enable_swapfile(){
    ui_print "- Setting Swappiness to $SWAPPINESS"
    sysctl vm.swappiness=$SWAPPINESS
    ui_print "- Now Reboot and see if it works!!"
}

# Start install
function custom_install() {
    ui_print "- Please keep the screen on during installation"
    ui_print "- Version $SWAP_MOD_VERSION"
    ui_print "- SWAP-SIZE: $SWAP_BIN_SIZE (MB)"
    ui_print "- SWAPPINESS: $SWAPPINESS"
    ui_print "- SWAP_FILE_PRIOR: $SWAP_FILE_PRIOR"
    ui_print "- SWAP_FILE_PATH: $SWAP_FILE_PATH"
    create_swapfile
    enable_swapfile
}

# # Custom installation
custom_install
