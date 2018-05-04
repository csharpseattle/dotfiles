#!/bin/bash

#
# Install Homebrew.  It gets used a lot.
#
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#
# Change the computer name.  scutil can set the ComputerName, LocalHostName, and HostName
#
sudo scutil --set ComputerName $USER
#sudo scutil --set HostName $USER
#sudo scutil --set LocalHostName $USER

#
#  Show all file extensions
#
defaults write NSGlobalDomain AppleShowAllExtensions -bool true


# Disable the crash reporter
#defaults write com.apple.CrashReporter DialogType -string "none"

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true


# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 20

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes



#
# Change keyboard preferences.  This will change the CapsLock to Control and swap the Option and Command key bindings
#
source "keyboard.sh"
changeKeyboardModifiers emacs

#
# Copy the terminal preferences to Library/Preferences
#
cp com.apple.Terminal.plist ~/Library/Preferences/

#
# Make the Development folder
#
for i in osx cvml csharp; do
    if [ ! -d ~/Development/${i} ]; then
    mkdir -p ~/Development/${i}
    fi
done
