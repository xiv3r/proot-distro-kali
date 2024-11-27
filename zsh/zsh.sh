#!/bin/sh

###
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
###
echo "
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
" >> ~/.zshrc && source ~/.zshrc
