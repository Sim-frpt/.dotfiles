#!/bin/bash

# Fzf

echo "####################"
echo "Installing fzf"
echo "####################"

fzf_dir=${HOME}/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fzf_dir/install
