#!/bin/sh

apt update && apt upgrade -y && 
apt install wget -y && 
echo "clear && proot-distro login kali" >> $PREFIX/etc/bash.bashrc && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/setup.sh | sh && 
proot-distro login kali

apt install -y proot-distro 
###
wget -O $PREFIX/etc/proot-distro/kali.sh https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/kali.sh
###
chmod a+x $PREFIX/etc/proot-distro/kali.sh
###
proot-distro install kali 


