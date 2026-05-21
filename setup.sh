
#!/bin/bash

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
B="$(printf '\033[1;34m')"
C="$(printf '\033[1;36m')"
W="$(printf '\033[1;37m')"

banner() {
clear
echo -e "${C}"
echo     "██╗   ██╗██████╗ ██╗   ██╗███╗   ██╗████████╗██╗   ██╗ ${R} ██╗  ██╗${W}"
echo "${C}██║   ██║██╔══██╗██║   ██║████╗  ██║╚══██╔══╝██║   ██║ ${R} ╚██╗██╔╝${W}"
echo "${C}██║   ██║██████╔╝██║   ██║██╔██╗ ██║   ██║   ██║   ██║ ${R}  ╚███╔╝ ${W}"
echo "${C}██║   ██║██╔══██╗██║   ██║██║╚██╗██║   ██║   ██║   ██║ ${R}  ██╔██╗ ${W}"
echo "${C}╚██████╔╝██████╔╝╚██████╔╝██║ ╚████║   ██║   ╚██████╔╝ ${R} ██╔╝ ██╗${W}"
echo "${C} ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝    ╚═════╝  ${R} ╚═╝  ╚═╝${W}"
echo -e "${B}UbuntuX - Minimal Termux Ubuntu - By Techy Dude${W}"
}

UBUNTU_DIR="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"
dir() {
if [ -d "$HOME/Storage/Android" ]; then
    echo "${G}Storage already configured!${W}"

elif [ -d "$HOME/storage/shared/Android" ]; then
    echo "${R}Storage not configured!${W}"
    echo ""
    echo "${Y}Please run the following commands manually:${W}"
    echo ""
    echo "${B}mv ~/storage/shared ~${W}"
    echo "${B}rm -rf ~/storage${W}"
    echo "${B}mv ~/shared ~/Storage${W}"

   exit 1
else
    echo "${R}Storage not configured!${W}"
    echo ""
    echo "${Y}Please run the following commands manually:${W}"
    echo ""
    echo "${C}termux-setup-storage${W}"
    echo "${B}mv ~/storage/shared ~${W}"
    echo "${B}rm -rf ~/storage${W}"
    echo "${B}mv ~/shared ~/Storage${W}"
    echo ""
    echo "${G}Or follow the instructions given in the GitHub repository!${W}"
   exit 1
fi
}
package() {
echo -e "${R} [${W}-${R}]${C} Checking for Installing packages... Please wait for two minutes...${W}"
pkg install root-repo x11-repo -y --no-install-recommends >/dev/null 2>&1
pkg install tur-repo -y >/dev/null 2>&1 
pkg install proot-distro pulseaudio termux-x11-nightly virglrenderer-android mesa -y --no-install-recommends
}
distro() {
   banner
    echo -e "${R} [${W}-${R}]${C} Checking for Distro...${W}"
    termux-reload-settings

    if [[ -d "$UBUNTU_DIR" ]]; then
        echo -e "\n${R} [${W}-${R}]${G} Distro already installed.${W}"
        exit 0
    fi

    if ! command -v proot-distro >/dev/null 2>&1; then
        echo -e "${R}[!] proot-distro not found.${W}"
        echo -e "${Y}Repo may be failing.${W}"
        echo -e "${Y}Run 'termux-change-repo', select a working mirror, then rerun this script.${W}"
        exit 1
    fi

    proot-distro install ubuntu
    termux-reload-settings

    cp ~/UbuntuX/OS.sh /$UBUNTU_DIR/root

    if [[ -d "$UBUNTU_DIR" ]]; then
        echo -e "${R} [${W}-${R}]${G} Installed Successfully !!${W}"
    else
        echo -e "${R} [${W}-${R}]${R} Error Installing Distro !${W}"
        exit 1
    fi
}
echo "Cleaning motd files..."

while pgrep dpkg >/dev/null || pgrep apt >/dev/null; do
    sleep 1
done

files=(
"$PREFIX/etc/motd"
"$PREFIX/etc/motd.sh"
"$PREFIX/etc/motd-playstore"
)

while :; do
    removed=true

    for file in "${files[@]}"; do
        rm -f "$file"
        [ -e "$file" ] && removed=false
    done

    $removed && break
    sleep 1
done

ubuntu() {
proot-distro login ubuntu -- bash -c "
bash OS.sh
"
}
banner
dir
package
distro
ubuntu
