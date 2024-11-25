#!/bin/sh

apt install -y proot-distro 
###
wget -O $PREFIX/etc/proot-distro/kali.sh https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/kali.sh
###
chmod a+x $PREFIX/etc/proot-distro/kali.sh
###
proot-distro install kali
