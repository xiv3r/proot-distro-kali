# Requirements
- [Termux](https://github.com/termux/termux-app/releases/download/v0.118.3/termux-app_v0.118.3+github-debug_universal.apk)

# Xfce Desktop 
```
pkg update && pkg upgrade -y && pkg install -y wget && clear && wget -q -O desktop.sh https://raw.githubusercontent.com/xiv3r/proot-distro-kali/refs/heads/main/desktop.sh && chmod 700 desktop.sh && bash desktop.sh
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
