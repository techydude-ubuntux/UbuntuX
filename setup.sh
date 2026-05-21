
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

UBUNTU_DIR="$PREFIX/var/lib/proot-distro/containers/ubuntu/rootfs"
dir() {
if [ -d "$HOME/Storage/Android" ]; then
    echo -e "\n${G}Storage already configured!${W}\n"

elif [ -d "$HOME/storage/shared/Android" ]; then
    echo -e "\n${R}Storage not configured!${W}"
    echo -e "\n${Y}Please run the following commands manually:${W}"
    echo -e "\n${B}mv ~/storage/shared ~${W}"
    echo -e "${B}rm -rf ~/storage${W}"
    echo -e "${B}mv ~/shared ~/Storage${W}\n"

  exit 1
else
    echo -e "$\n{R}Storage not configured!${W}"
    echo -e "\n${Y}Please run the following commands manually:${W}"
    echo -e "\n${C}termux-setup-storage${W}"
    echo -e "${B}mv ~/storage/shared ~${W}"
    echo -e "${B}rm -rf ~/storage${W}"
    echo -e "${B}mv ~/shared ~/Storage${W}"
    echo -e "\n${G}Or follow the instructions given in the GitHub repository!${W}\n"

  exit 1
fi
}
package() {
echo -e "${R} [${W}-${R}]${C} Checking for Installing packages...\n     Please wait for two minutes...${W}"
pkg install root-repo x11-repo -y --no-install-recommends >/dev/null 2>&1
pkg install tur-repo -y >/dev/null 2>&1
pkg install proot-distro pulseaudio termux-x11-nightly virglrenderer-android mesa -y --no-install-recommends
}
distro() {
   banner
    echo -e "\n${R} [${W}-${R}]${C} Checking for Distro...${W}"
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

    proot-distro install ubuntu:questing
    termux-reload-settings

    cp ~/UbuntuX/OS.sh /$UBUNTU_DIR/root/

    if [[ -d "$UBUNTU_DIR" ]]; then
        echo -e "${R} [${W}-${R}]${G} Installed Successfully !!${W}"
    else
        echo -e "${R} [${W}-${R}]${R} Error Installing Distro !${W}"
        exit 1
    fi
}

clean() {
    echo "Cleaning motd files..."

    while pgrep dpkg >/dev/null || pgrep apt >/dev/null; do
        sleep 1
    done

    files=(
        "$PREFIX/etc/motd"
        "$PREFIX/etc/motd.sh"
        "$PREFIX/etc/motd-playstore"
    )

    for a in "${files[@]}"; do
        [ -e "$a" ] && rm -rf "$a"
    done
}

ubuntu() {
proot-distro login ubuntu -- bash -c "
bash OS.sh
"
}
banner
dir
package
distro
clean
ubuntu
