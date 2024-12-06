Auto install
auto launch kali in every start-up cli by default

apt update && apt upgrade -y && pkg install wget -y && echo "clear && proot-distro login kali" >> $PREFIX/etc/bash.bashrc && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/setup.sh | sh && proot-distro login kali
apt update && apt install wget -y && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/zsh/zsh.sh | sh && source .zshrc
Upgrade Kali

apt full-upgrade -y
Add custom terminal name
replace the name xiv3r to your name

sed -i 's/user=kali/user=xiv3r/' .zshrc && source .zshrc


Uninstall
proot-distro remove kali
