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

source ~/.bashrc
