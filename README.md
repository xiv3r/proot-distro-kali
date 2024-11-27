# Auto install
> auto launch kali in every start-up
> cli by default
```sh
apt update && apt upgrade -y && pkg install wget -y && echo "clear && proot-distro login kali" >> $PREFIX/etc/bash.bashrc && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/setup.sh | sh && proot-distro login kali
```
```sh
apt update && apt -y full-upgrade
```
## Add custom terminal name
> replace the name `xiv3r` to your name
```sh
sed -i 's/user=kali/user=xiv3r/' .zshrc && source .zshrc
```
## Uninstall
```sh
proot-distro remove kali
```
