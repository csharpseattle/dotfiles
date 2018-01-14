#!/bin/bash

function findKeyboardDomainString()
{
    #
    # We look for the Keyboard device in the io registry
    #
    #
    # First we look for 'Apple Keyboard', Hopefully this is the
    # keyboard device on non-laptops.  Since there may be more
    # than one device KEYBOARDS is a bash array of devices. To
    # properly store the items in the array we need to modify IFS
    #
    IFS=$'\n'
    KEYBOARDS=($(ioreg | grep --null -o "Apple Keyboard[^<]*"))

    #
    # If the array length is 0 we try "Apple Internal Keyboard" which
    # should find the device on a laptop
    #
    if [ ${#KEYBOARDS[@]} -eq 0 ]; then
        KEYBOARDS=($(ioreg | grep --null -o "Apple Internal Keyboard[^<]*"))
    fi

    #
    # if the array length is still 0 then we are out of luck.
    #
    if [ ${#KEYBOARDS[@]} -eq 0 ]; then
        exit 1;
    fi

    #
    # Otherwise we have found a device.  Use ioreg to report on the keyboard
    # and return the idVendor and idProduct properties.
    #
    KEYBOARD_DEVICE=${KEYBOARDS[0]}

    #
    # Trim trailing whitespace
    #
    KEYBOARD_DEVICE=$(echo $KEYBOARD_DEVICE | sed "s/ *$//g")

    #
    # Look in the IO registry for the Product and Vendor ids associated with the keyboard device
    #
    IOREGINFO=$(ioreg -n "$KEYBOARD_DEVICE" -r | grep -e "idProduct" -e "idVendor" | paste - - - - - - - -)
    KEYBOARD_PRODUCT=$(echo $IOREGINFO | awk '{print $4;}')
    KEYBOARD_VENDOR=$(echo $IOREGINFO | awk '{print $8;}')

    #
    # echo the domain string for use in the defaults command.
    # e.g. to read the key mappings you would use:
    #       defaults -currentHost read -g com.apple.keyboard.modifiermapping.${KEYBOARD_VENDOR}-${KEYBOARD_PRODUCT}-0
    #
    # OR, once this function is defined:
    #       defaults -currentHost read -g $(findKeyboardDomainString)
    #
    echo "com.apple.keyboard.modifiermapping.${KEYBOARD_VENDOR}-${KEYBOARD_PRODUCT}-0"
}


function changeKeyboardModifiers()
{

    LEFT_CONTROL=30064771296
    CAPS_LOCK=30064771129
    LEFT_COMMAND=30064771299
    LEFT_OPTION=30064771298
    RIGHT_COMMAND=30064771303
    RIGHT_OPTION=30064771302

    if [ -n "$1" ]; then
        echo "okay --------------------"
        if [ $1 = "emacs" ]; then
            echo "good =------------ - - -  $(findKeyboardDomainString)"
            #
            # Change caps lock to ctrl
            #
            defaults -currentHost write -g $(findKeyboardDomainString) -array-add "<dict><key>HIDKeyboardModifierMappingDst</key><integer>$LEFT_CONTROL</integer><key>HIDKeyboardModifierMappingSrc</key><integer>$CAPS_LOCK</integer></dict>"

            #
            # Change left option to left command
            #
            defaults -currentHost write -g $(findKeyboardDomainString) -array-add "<dict><key>HIDKeyboardModifierMappingDst</key><integer>$LEFT_COMMAND</integer><key>HIDKeyboardModifierMappingSrc</key><integer>$LEFT_OPTION</integer></dict>"

            #
            # Change left command to left option
            #
            defaults -currentHost write -g $(findKeyboardDomainString) -array-add "<dict><key>HIDKeyboardModifierMappingDst</key><integer>$LEFT_OPTION</integer><key>HIDKeyboardModifierMappingSrc</key><integer>$LEFT_COMMAND</integer></dict>"

            #
            # Change right option to right command
            #
            defaults -currentHost write -g $(findKeyboardDomainString) -array-add "<dict><key>HIDKeyboardModifierMappingDst</key><integer>$RIGHT_COMMAND</integer><key>HIDKeyboardModifierMappingSrc</key><integer>$RIGHT_OPTION</integer></dict>"

            #
            # Change right command to right option
            #
            defaults -currentHost write -g $(findKeyboardDomainString) -array-add "<dict><key>HIDKeyboardModifierMappingDst</key><integer>$RIGHT_OPTION</integer><key>HIDKeyboardModifierMappingSrc</key><integer>$RIGHT_COMMAND</integer></dict>"
        fi
    else
        echo "Removing keyboard modifiers"
        defaults -currentHost delete -g $(findKeyboardDomainString)
    fi
}
