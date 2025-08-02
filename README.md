# Requirements
- [Termux APP](https://github.com/termux/termux-app/releases)
- [Termux X11](https://github.com/termux/termux-x11/releases)
- [Termux API](https://github.com/termux/termux-api/releases)

# Xfce Desktop 
```diff
-; pkg update && pkg upgrade -y && pkg install -y wget && clear && wget -q -O desktop.sh https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/desktop.sh && chmod 700 desktop.sh && bash desktop.sh
```
# Auto Install [ARM64]
```diff
-; pkg update && pkg upgrade -y && pkg install wget -y && clear && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/arm64 | bash && kali
```
# Auto Install [ARMHF]
```diff
-; pkg update && pkg upgrade -y && pkg install wget -y && clear && wget -qO- https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/armhf | bash && kali
```
<br>

<img src="https://github.com/xiv3r/proot-distro-kali/blob/main/kali.png">

## Login user
```
kali
```
## Logout
```
exit
```
## Uninstall
```
uninstall-kali
```
## Reinstall
```
pd reinstall kali
```
## Reset
```
pd reset kali
```
