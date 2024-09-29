#!/bin/bash

# essentials
sudo apt install vim tmux stow

# QoL
sudo apt install tree

# TODO add steps for installing fzf, if you want

# create symlinks to these dotfiles in ~
stow -t ~ .

echo ''
echo '###################################'
echo '### System setup complete; GLHF ###'
echo '###################################'
echo ''
