# Auto install
```sh
apt update && apt upgrade -y && pkg install wget -y && echo "clear && proot-distro login kali" >> $PREFIX/etc/bash.bashrc && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/setup.sh | sh && proot-distro login kali
```
- CLI Only
```sh
apt update && apt install -y wget && wget -O /etc/bash.bashrc https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/bash.bashrc && source /etc/bash.bashrc
```
- CLI & VNC
```sh
apt update && apt install -y wget && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/files/xfce.sh | sh
```
- Add custom terminal username
> Replace the name xiv3r to your name
```sh
sed -i 's/user=kali/user=xiv3r/' /etc/bash.bashrc && source /etc/bash.bashrc
```
<img src="https://github.com/xiv3r/proot-distro-kali/blob/main/files/kalinh.png">
## Uninstall
```sh
proot-distro remove kali
```

