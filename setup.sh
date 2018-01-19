#!/bin/bash


#
# if .bashrc and/or .zshrc are symbolic links we simply
# break them.  We will setup our own links
#
if [[ -h ~/.bashrc ]]; then
    rm ~/.bashrc
fi

if [[ -h ~/.zshrc ]]; then
    rm ~/.zshrc
fi


#
# if .bashrc and/or .zshrc exist as files we move them aside.
#
if [[ -f ~/.bashrc ]]; then
    mv ~/.bashrc ~/.bashrc_moved_aside
fi

if [[ -f ~/.zshrc ]]; then
    mv ~/.zshrc ~/.zshrc_moved_aside
fi


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
# symlink .gitconfig
#
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig


#
# Setup emacs.d
#
if [ ! -d ~/.emacs.d ]; then
    mkdir ~/.emacs.d
fi


#
#  symlink init.el and then lisp directory
#
if [ -f ~/.emacs.d/init.el ]; then
    mv ~/.emacs.d/init.el ~/.emacs.d/init.el.moved_aside
    ln -s ~/.dotfiles/emacs/init.el ~/.emacs.d/init.el
    ln -s ~/.dotfiles/emacs/lisp ~/.emacs.d/lisp
fi


source ~/.bashrc
