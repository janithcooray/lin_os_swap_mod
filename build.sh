#!/bin/sh
# BEFORE EDITING THIS FILE
# make sure the commands used are compatible with unix like systems across.
# for example, darwin's (macOS) version of sed and ubuntu's version of sed is different
# so make sure the same commands work work across in bourne shell

# You need to have the following installed
# - git
# - zip

# Don't forget to increment these
MODFILE_VERSION="v2.0-a"
MODFILE_VERCODE="8"

set -eu
REPO_TOPLEVEL=$(git rev-parse --show-toplevel)

# Legacy
rm -f lin_os_swap_mod.zip
rm -f module.zip
rm -f swapfile_mod.zip

# Current
rm -rf $REPO_TOPLEVEL/release
rm -f $REPO_TOPLEVEL/module/module.prop



mkdir ./release

for FILE in "config"/*.sh; do
    if [ -f "$FILE" ]; then
        cd $REPO_TOPLEVEL
        VARIENT_NAME=$(basename "$FILE" .sh)
        echo "Config $VARIENT_NAME"
        cp $REPO_TOPLEVEL/config/module.prop $REPO_TOPLEVEL/module/module.prop
        echo "version=$MODFILE_VERSION" >> $REPO_TOPLEVEL/module/module.prop
        echo "versionCode=$MODFILE_VERCODE" >> $REPO_TOPLEVEL/module/module.prop
        # Update JSON File
        echo "{\"version\": $MODFILE_VERSION,\"versionCode\": $MODFILE_VERCODE," > "$REPO_TOPLEVEL/release/$VARIENT_NAME.json"
        echo "\"zipUrl\": \"https://github.com/janithcooray/lin_os_swap_mod/releases/latest/download/$VARIENT_NAME.zip\",\"changelog\": url}" >> "$REPO_TOPLEVEL/release/$VARIENT_NAME.json"
        echo "updateJson=" >> "https://github.com/janithcooray/lin_os_swap_mod/releases/latest/download/$VARIENT_NAME.json"

        rm -f "$REPO_TOPLEVEL/release/$VARIENT_NAME.zip";
        cp "$REPO_TOPLEVEL/config/$VARIENT_NAME.sh" "$REPO_TOPLEVEL/module/vars.sh"
        # We have to inside and zip 
        # the zip should directly be the content inside module
        # not module itself. doing this from root seem to issues 
        # in some variations of zip
        (cd $REPO_TOPLEVEL/module && zip -r "$REPO_TOPLEVEL/release/$VARIENT_NAME.zip" .)
    fi
done


# Legacy
# 4096_60_auto is default
cp $REPO_TOPLEVEL/release/4096_60_auto.zip lin_os_swap_mod.zip
cp $REPO_TOPLEVEL/release/4096_60_auto.zip swapfile_mod.zip

# Current
