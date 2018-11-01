#!/bin/bash

#
# Handle existing bashrc, zshrc, tmux.conf and gitconfig
#
for i in ~/.bashrc ~/.zshrc ~/.tmux.conf ~/.gitconfig; do

    #
    # if any of the above  are symbolic links we simply
    # break them.  We will setup our own links
    #
    if [[ -h ${i} ]]; then
        rm ${i}
    fi

    #
    # if .bashrc, .zshrc, .tmux.conf, .gitconfig exist as
    # in the hone directory and are not symlinks we move them aside.
    #
    if [[ -f $i ]]; then
        mv $i ${i}_moved_aside
    fi
done



#
# If we are on a mac we will need the XCode Command Line Tools
#
if [ $(uname) = "Darwin" ]; then
    xcode-select -p &> /dev/null
    if [ ! $? -eq 0 ]; then
        xcode-select --install
    fi
fi


#
# Clone the dotfiles repo
#
if [[ ! -d ~/.dotfiles ]]; then
    git clone https://github.com/csharpseattle/dotfiles ~/.dotfiles
fi


#
# make a symlink to the dotfilesrc for both bash and zsh
#
for i in .bashrc .zshrc; do
    ln -s ~/.dotfiles/dotfilesrc ~/${i}
done

#
# symlink tmux.conf
#
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf


#
# symlink .gitconfig
#
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig


#
# Setup emacs.d
#
if [ -d ~/.emacs.d ]; then
    mv ~/.emacs.d ~/.emacs.d.moved_aside
fi


#
#  symlink emacs dir
#
ln -s ~/.dotfiles/emacs ~/.emacs.d



source ~/.bashrc
