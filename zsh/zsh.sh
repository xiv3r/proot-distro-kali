#!/bin/sh


apt install unzip -y
###
wget https://github.com/xiv3r/proot-distro-kali/blob/main/zsh/zsh.zip
###
unzip -d ~./zsh zsh.zip
###
echo "
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
" >> ~/.zshrc && source ~/.zshrc
