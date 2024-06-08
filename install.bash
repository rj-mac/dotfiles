#!/bin/bash

# essentials
sudo apt install vim tmux stow

# QoL
sudo apt install tree

# clone and install latest fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# TODO add install for latest neovim release

# create symlinks to these dotfiles in ~
stow -t ~ .

echo ''
echo '###################################'
echo '### System setup complete; GLHF ###'
echo '###################################'
echo ''
