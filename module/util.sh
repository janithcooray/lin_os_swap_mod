NO_VK=1

# orginally done by Kingsman44 @xda-developers
keytest() {
    timeout 2
    ui_print "- Vol Key Test"
    ui_print "    Press a Vol Key:"
    if (timeout 5 /system/bin/getevent -lc 1 2>&1 | /system/bin/grep VOLUME | /system/bin/grep " DOWN" >$TMPDIR/events); then
        return 0
    else
        ui_print "   Try again:"
        timeout 5 $MODPATH/addon/keycheck
        local SEL=$?
        [ $SEL -eq 143 ] && abort "   Vol key not detected!" || return 1
    fi
}

chooseport() {
    # Original idea by chainfire @xda-developers, improved on by ianmacd @xda-developers
    #note from chainfire @xda-developers: getevent behaves weird when piped, and busybox grep likes that even less than toolbox/toybox grep
    while true; do
        /system/bin/getevent -lc 1 2>&1 | /system/bin/grep VOLUME | /system/bin/grep " DOWN" >$TMPDIR/events
        if ($(cat $TMPDIR/events 2>/dev/null | /system/bin/grep VOLUME >/dev/null)); then
            break
        fi
    done
    if ($(cat $TMPDIR/events 2>/dev/null | /system/bin/grep VOLUMEUP >/dev/null)); then
        if [ $TURN_OFF_SEL_VOL_PROMPT -eq 0 ]; then
            print ""
            print "  Selected: Volume Up"
            print ""
        fi
        return 0
    else
        if [ $TURN_OFF_SEL_VOL_PROMPT -eq 0 ]; then
            print ""
            print "  Selected: Volume Down"
            print ""
        fi
        return 1
    fi
}

chooseportold() {
    # Keycheck binary by someone755 @Github, idea for code below by Zappo @xda-developers
    # Calling it first time detects previous input. Calling it second time will do what we want
    while true; do
        $MODPATH/addon/keycheck
        local SEL=$?
        if [ "$1" == "UP" ]; then
            UP=$SEL
            break
        elif [ "$1" == "DOWN" ]; then
            DOWN=$SEL
            break
        elif [ $SEL -eq $UP ]; then
            if [ $TURN_OFF_SEL_VOL_PROMPT -eq 0 ]; then
                print ""
                print "  Selected: Volume Up"
                print ""
            fi
            sed -i -e "s/${CURR} \[\-/${CURR} \[\O/g" $ 
            return 0
        elif [ $SEL -eq $DOWN ]; then
            if [ $TURN_OFF_SEL_VOL_PROMPT -eq 0 ]; then
                print ""
                print "  Selected: Volume Down"
                print ""
            fi
            sed -i -e "s/${CURR} \[\-/${CURR} \[\X/g" $logfile
            return 1
        fi
    done
}