<p align="center"><img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fxiv3r%2Fproot-distro-kali&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=%F0%9F%91%81%EF%B8%8F+%F0%9F%91%81%EF%B8%8F&edge_flat=false">

# Auto install
> auto launch kali in every start-up
> cli by default
```sh
apt update && apt upgrade -y && pkg install wget -y && echo "clear && proot-distro login kali" >> $PREFIX/etc/bash.bashrc && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/setup.sh | sh && proot-distro login kali
```
```sh
apt update && apt install wget -y && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/zsh/zsh.sh | sh && source .zshrc
```
> Upgrade Kali
```sh
apt full-upgrade -y
```
## Add custom terminal name
> replace the name `xiv3r` to your name
```sh
sed -i 's/user=kali/user=anton/' .zshrc && source .zshrc
```

<img src="https://github.com/xiv3r/proot-distro-kali/blob/main/files/kalizshrc.png">

## Uninstall
```sh
proot-distro remove kali
```
