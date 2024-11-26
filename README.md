# Auto install
> auto launch kali in every start-up
> cli by default
```sh
apt update && apt upgrade -y && pkg install wget -y && echo "clear && proot-distro login kali" >> $PREFIX/etc/bash.bashrc && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/setup.sh | sh && proot-distro login kali
```

## Uninstall
```sh
proot-distro remove kali
```
