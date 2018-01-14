#!/bin/bash

#
# Install Homebrew.  It gets used a lot.
#
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#
# Change the computer name.  scutil can set the ComputerName, LocalHostName, and HostName
#
sudo scutil -set ComputerName $USER
#sudo scutil -set HostName $USER
#sudo scutil -set LocalHostName $USER

#
# Change keyboard preferences.  This will change the CapsLock to Control and swap the Option and Command key bindings
#
source "keyboard.sh"
changeKeyboardModifiers emacs

#
# Copy the terminal preferences to Library/Preferences
#
cp com.apple.Terminal.plist ~/Library/Preferences/
