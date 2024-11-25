DISTRO_NAME="kali"
TARBALL_URL['aarch64']="https://github.com/xiv3r/proot-distro-kali/releases/download/proot-distro/kali-rolling_arm64-rootfs.tar.xz"
TARBALL_SHA256['aarch64']="c49fab64df4b427d240c0af078cca4a58ed1db6c66a321d5f3ab479007a64b1f"
distro_setup() {
        # Configure en_US.UTF-8 locale.
        sed -i -E 's/#[[:space:]]?(en_US.UTF-8[[:space:]]+UTF-8)/\1/g' ./etc/locale.gen
        run_proot_cmd DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
}
