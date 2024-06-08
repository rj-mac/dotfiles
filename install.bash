#!/bin/bash

# essentials
sudo apt install vim tmux stow

# QoL
sudo apt install tree

# TODO add install for latest neovim release
# TODO add install for latest fzf release

# create symlinks to these dotfiles in ~
stow -t ~ .

echo ''
echo '###################################'
echo '### System setup complete; GLHF ###'
echo '###################################'
echo ''
