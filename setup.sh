#!/data/data/com.termux/files/usr/bin/bash

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
B="$(printf '\033[1;34m')"
C="$(printf '\033[1;36m')"
W="$(printf '\033[1;37m')"

banner() {
clear
wid=$(stty size | cut -d ' ' -f 2)
if (( wid  >= 66 )); then
echo -e "${C}"
echo     " ██╗   ██╗██████╗ ██╗   ██╗███╗   ██╗████████╗██╗   ██╗ ${R} ██╗  ██╗${W}"
echo "${C} ██║   ██║██╔══██╗██║   ██║████╗  ██║╚══██╔══╝██║   ██║ ${R} ╚██╗██╔╝${W}"
echo "${C} ██║   ██║██████╔╝██║   ██║██╔██╗ ██║   ██║   ██║   ██║ ${R}  ╚███╔╝ ${W}"
echo "${C} ██║   ██║██╔══██╗██║   ██║██║╚██╗██║   ██║   ██║   ██║ ${R}  ██╔██╗ ${W}"
echo "${C} ╚██████╔╝██████╔╝╚██████╔╝██║ ╚████║   ██║   ╚██████╔╝ ${R} ██╔╝ ██╗${W}"
echo "${C}  ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝    ╚═════╝  ${R} ╚═╝  ╚═╝${W}"
echo -e "${B}   UbuntuX - Minimal Termux Ubuntu - Techy Dude${W}"
else
text="UbuntuX 🚀 - Techy Dude"
pad=$(( (wid - ${#text}) / 2 ))
(( pad < 0 )) && pad=0
printf "%*s" "$pad" ""
echo -e "${C}Ubuntu${R}X 🚀 ${G}-${B} Techy Dude${W}"
fi
}

play() {
echo -e "${C}Checking CPU architecture..${W}"

if [ "$(uname -m)" = "armv7l" ]; then
    echo -e "${R}Sorry! armv7l architecture is not supported..${W}"
    exit 1
fi

echo -e "${G}CPU architecture is OK..!${W}"

if [[ "$TERMUX_VERSION" == googleplay* ]]; then

    echo -e "\n ⚠️ ${Y}Termux Play Store version detected!${W}"
    echo -e "❌ ${R}The Play Store version is unsupported!${W}"
    echo -e "\n${R} [${W}-${R}]${G} Please reinstall from F-Droid or GitHub repository.${W}"
    exit 1

fi
}

andro() {
banner
android_version_code=$(getprop ro.system.build.version.release)
if (( $android_version_code >= 12 )); then
    sleep 1
    echo -e "\n ⚠️ ${R} Android version ${android_version_code} detected!${W}"
    echo -e "\n${R} [${W}-${R}]${Y} You may experience issues like crashing!${W}"
    echo -e "\n${R} [${W}-${R}]${G} To fix signal 9 issue:\n ${B}Follow the steps given on: \n ${C}Ubuntu${R}X🚀 ${B}github repository ${R} Topic: ${C}Phantom Process Fix${W}"
    sleep 2
fi
}

UBUNTU_DIR="$PREFIX/var/lib/proot-distro/containers/ubuntu/rootfs"
dir() {
banner
if [ -d "$HOME/Storage/Android" ]; then
    echo -e "\n${G} Storage already configured!${W}\n"

elif [ -d "$HOME/storage/shared/Android" ]; then
    echo -e "\n${R} Storage not configured!${W}"
    echo -e "\n${Y} Please run the following commands manually:${W}"
    echo -e "\n${B} mv ~/storage/shared ~${W}"
    echo -e "${B} rm -rf ~/storage${W}"
    echo -e "${B} mv ~/shared ~/Storage${W}\n"
    echo -e "${C} bash ~/UbuntuX/setup.sh${W}"

  exit 1
else
    echo -e "\n${R} Storage not configured!${W}"
    echo -e "\n${Y} Please run the following commands manually:${W}"
    echo -e "\n${C} termux-setup-storage${W}"
    echo -e "${B} mv ~/storage/shared ~${W}"
    echo -e "${B} rm -rf ~/storage${W}"
    echo -e "${B} mv ~/shared ~/Storage${W}"
    echo -e "${C} bash ~/UbuntuX/setup.sh${W}\n"
    echo -e "\n${G} Or follow the instructions given in the GitHub repository!${W}\n"

  exit 1
fi
}
package() {
echo -e "${R} [${W}-${R}]${C} Checking for Installing packages...\n ${R}[${W}-${R}]${Y} Please wait for two minutes...${W}"
yes | pkg up
pkg install root-repo x11-repo -y --no-install-recommends 
pkg install tur-repo -y
pkg install proot-distro pulseaudio termux-x11-nightly virglrenderer-android mesa mesa-zink virglrenderer-mesa-zink vulkan-loader-android -y --no-install-recommends
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
        echo -e "${Y} Repo may be failing.${W}"
        echo -e "${Y} Run 'termux-change-repo', select a working mirror,\n then rerun this script using ${C}bash ~/UbuntuX/setup.sh${Y}.${W}"
        
        exit 1
    fi

    proot-distro install ubuntu:noble >/dev/null 2>&1
    termux-reload-settings

    cp ~/UbuntuX/OS.sh /$UBUNTU_DIR/root/

    if [[ ! -d "$UBUNTU_DIR" ]]; then
        echo -e "${R} [${W}-${R}]${R} Error Installing Distro !${W}"
    fi
}

clean() {
    echo -e "\n${R} [${W}-${R}]${C} Cleaning motd files...${W}"

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
play
andro
dir
package
distro
clean
ubuntu
