#!/bin/bash

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
B="$(printf '\033[1;34m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"

banner() {
sleep 1
clear
wid=$(stty size | cut -d ' ' -f 2)
if (( wid  >= 66 )); then
echo "${C} ██╗   ██╗██████╗ ██╗   ██╗███╗   ██╗████████╗██╗   ██╗ ${R} ██╗  ██╗${W}"
echo "${C} ██║   ██║██╔══██╗██║   ██║████╗  ██║╚══██╔══╝██║   ██║ ${R} ╚██╗██╔╝${W}"
echo "${C} ██║   ██║██████╔╝██║   ██║██╔██╗ ██║   ██║   ██║   ██║ ${R}  ╚███╔╝ ${W}"
echo "${C} ██║   ██║██╔══██╗██║   ██║██║╚██╗██║   ██║   ██║   ██║ ${R}  ██╔██╗ ${W}"
echo "${C} ╚██████╔╝██████╔╝╚██████╔╝██║ ╚████║   ██║   ╚██████╔╝ ${R} ██╔╝ ██╗${W}"
echo "${C}  ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝    ╚═════╝  ${R} ╚═╝  ╚═╝${W}"
echo -e "${B}   UbuntuX 🚀 - Minimal Termux Ubuntu - Techy Dude${W}"
else
text="UbuntuX 🚀 - Techy Dude"
pad=$(( (wid - ${#text}) / 2 ))
(( pad < 0 )) && pad=0
printf "%*s" "$pad" ""
echo -e "${C}Ubuntu${R}X 🚀 ${G}-${B} Techy Dude${W}"
fi
}

arch=$(uname -m)
term="/data/data/com.termux/files/usr"

sudo() {
echo -e "\n${R} [${W}-${R}]${C} Installing Sudo & System Utilities...${W}"
apt update -y && apt upgrade -y
apt install sudo -y || echo -e "\n${R}❌ Sudo Installation failed!${W}\n"
base_packs=(
  wget
  apt-utils
  locales-all
  locales
  dialog
  tzdata
  gnupg2
  curl
  nano
  git
  software-properties-common
  xz-utils
  at-spi2-core
  librsvg2-common
  menu
  ca-certificates
  inetutils-tools
  exo-utils
  dbus-x11
  apt-transport-https
 )
 apt install -y "${base_packs[@]}" --no-install-recommends
 locale-gen en_US.UTF-8
echo -e "\n${R} [${W}-${R}]${G} Sudo Successfully Installed!${W}"
}

login() {
banner
echo -e "\n${R} [${G}-${R}]${G} In username:\n ${R} 1. No spaces allowed!\n  2. No special symbols allowed!\n${R} [${G}-${R}] ${G}Only lowercase letters allowed!${W}\n"
while true; do
    read -p "${R} [${G}~${R}]${Y} Enter Username: ${C}" user
    read -p "${R} [${G}~${R}]${Y} Enter Password: ${C}" pass

    if [[ -n "$user" && -n "$pass" ]]; then
        break
    fi
echo -e "${R}[!] Username and Password cannot be empty.${N}"
done
useradd -m -s  $(which bash) ${user}
usermod -aG sudo ${user}
echo "root:${pass}" | chpasswd
echo "${user}:${pass}" | chpasswd
echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$user"
chmod 440 "/etc/sudoers.d/$user"
cat > $term/bin/UbuntuX << EOF
#!/data/data/com.termux/files/usr/bin/bash

kill -9 \$(pgrep -f "termux.x11") >/dev/null 2>&1
kill -9 \$(pgrep -f "virgl") >/dev/null 2>&1
kill -9 \$(pgrep -f "pulseaudio") >/dev/null 2>&1

{ MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT MESA_GLES_VERSION_OVERRIDE=3.2 GALLIUM_DRIVER=zink vblank_mode=0 virgl_test_server --use-egl-surfaceless & } >/dev/null 2>&1

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

export XDG_RUNTIME_DIR=\${TMPDIR}
termux-x11 :0 -ac >/dev/null 2>&1 &
sleep 1

am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1
sleep 1

proot-distro login  --user $user ubuntu --bind /dev/null:/proc/sys/kernel/cap_last_cap --shared-tmp --fix-low-ports

exit 0
EOF

chmod +x $term/bin/UbuntuX

cat >> /etc/bash.bashrc << 'EOF'
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax)
    export DBUS_SESSION_BUS_ADDRESS
fi

export XDG_RUNTIME_DIR=/tmp
export PULSE_SERVER=127.0.0.1
export GALLIUM_DRIVER=virpipe
export vblank_mode=0
export TERM=xterm-256color
export LANG=C.UTF-8
export DISPLAY=:0
if [ -z "$XFCE_STARTED" ]; then
export XFCE_STARTED=1
{ dbus-launch --exit-with-session xfce4-session & } >/dev/null 2>&1
fi
EOF

cat >> /home/"$user"/.bash_logout << 'EOF'
kill -9 $(pgrep -f "termux.x11") >/dev/null 2>&1
kill -9 $(pgrep -f "virgl") >/dev/null 2>&1
kill -9 $(pgrep -f "pulseaudio") >/dev/null 2>&1
rm -rf /tmp/.X1-lock
rm -rf /tmp/.X11-unix/X1
EOF

cat >> /root/.bash_logout << 'EOF'
kill -9 $(pgrep -f "termux.x11") >/dev/null 2>&1
kill -9 $(pgrep -f "virgl") >/dev/null 2>&1
kill -9 $(pgrep -f "pulseaudio") >/dev/null 2>&1
rm -rf /tmp/.X1-lock
rm -rf /tmp/.X11-unix/X1
EOF

}

package() {
   banner
   apt-get update -y
   apt install udisks2 -y --no-install-recommends >/dev/null 2>&1
   rm /var/lib/dpkg/info/udisks2.postinst >/dev/null 2>&1
   echo "" > /var/lib/dpkg/info/udisks2.postinst
   dpkg --configure -a
   apt-mark hold udisks2
   apt purge --autoremove -y
   apt update -y && apt upgrade -y
   echo -e "\n${R} [${W}-${R}]${C} Checking required packages...${W}"
   packs=(
  xfce4
  xfce4-terminal
  glmark2
  mesa-utils
  xfce4-screenshooter
  mousepad
  ristretto
  sl
  vkmark
  vulkan-tools
  fastfetch
  )
  apt install -y --no-install-recommends "${packs[@]}" && echo -e "\n${R} [${W}-${R}]${C} Desktop Environment successfully installed!${W}" || echo -e "\n❌${R} Installation failed!${W}"
  [[ $(command -v xfce4-session) ]] || exit 1
  apt purge --autoremove -y
  apt-get update -y
  apt-get upgrade -y
  apt purge --autoremove -y
}

install_apt() {
  for apt in "$@"; do
  [[ `command -v $apt` ]] && echo -e "\n${Y} ${apt} is already Installed!${W}" || {
   echo -e "\n${R} [${W}-${R}]${G} Installing package : ${Y}${apt}${W}"
   apt-get install ${apt} -y --no-install-recommends
}
  done
}

install_vscode() {
[[ $(command -v code) ]] && echo -e "\n${Y} VSCode is already Installed!${W}" || {
banner
echo -e "\n${R} [${W}-${R}]${C} Installing VS Code...${W}"
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=arm64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
tee /etc/apt/preferences.d/vscode <<EOF
Package: code
Pin: origin packages.microsoft.com
Pin-Priority: 1001
EOF
apt update -y && apt upgrade -y
apt install code --no-install-recommends -y && echo -e "\n${R} [${W}-${R}]${C} VS code successfully installed!${W}" || echo -e "\n❌${R} VS Code Installation failed!${W}"
  }
}

install_firefox() {
[[ $(command -v firefox) ]] && echo -e "\n${Y} Firefox is already Installed!${W}" || {
banner
echo -e "\n${R} [${W}-${R}]${C} Installing Firefox...${W}"
rm -f /etc/apt/sources.list.d/*mozilla* && rm -f /etc/apt/sources.list.d/*firefox*
add-apt-repository -y ppa:mozillateam
tee /etc/apt/preferences.d/mozilla-firefox <<EOF
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
apt update && apt upgrade -y
apt install firefox --no-install-recommends -y && echo -e "\n${R} [${W}-${R}]${C} Firefox successfully installed!${W}" || echo -e "\n❌${R} Firefox Installation failed!${W}"
  }
}

install_bluej() {
[[ $(command -v bluej) ]] && echo -e "\n${Y} BlueJ is already Installed!${W}" || {
  banner
  echo -e "\n${R} [${W}-${R}]${C} Downloading BlueJ...${W}"
  wget -qO "$term"/../home/UbuntuX/patches/BlueJ-linux-arm64-5.5.0.deb https://www.bluej.org/download/files/BlueJ-linux-arm64-5.5.0.deb
  BLUEJ_FILE=$(ls "$term"/../home/UbuntuX/patches/BlueJ*.deb 2>/dev/null | head -n 1)
  if [ -z "$BLUEJ_FILE" ]; then
  echo -e "\n❌ ${R}No BlueJ .deb file found!${W}"
  return 1
fi

    install_apt "openjdk-25-jdk"
    echo -e "\n${R} [${W}-${R}]${C} Installing BlueJ...${W}"
    apt install "$BLUEJ_FILE" && apt --fix-broken install -y

    if dpkg -s bluej >/dev/null 2>&1; then
    sleep 1
    rm -rf /usr/share/pixmaps/bluej.xpm >/dev/null 2>&1
    sleep 1
    cp -rf /usr/share/bluej/images/bluej-icon-256.png /usr/share/pixmaps/
    sleep 1
    mv /usr/share/pixmaps/bluej-icon-256.png /usr/share/pixmaps/bluej.png
    sleep 1
        echo -e "\n${R} [${W}-${R}]${C} BlueJ Installed Successfully${W}"
    else
        echo -e "\n❌${R}BlueJ installation failed!${W}"
    fi
  }
}
install_chrome() {
[[ $(command -v google-chrome-stable) ]] && echo -e "\n${Y} Google Chrome is already Installed!${W}" || {
echo -e "\n${R} [${W}-${R}]${C} Installing Google Chrome...${W}"
wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg > /dev/null
echo 'X-Repolib-Name: Google Chrome
Types: deb
URIs: https://dl.google.com/linux/chrome-stable/deb/
Suites: stable
Components: main
Architectures: arm64
Signed-By: /usr/share/keyrings/google-chrome.gpg' | sudo tee /etc/apt/sources.list.d/google-chrome.sources >/dev/null
echo 'repo_add_once=false' | sudo tee /etc/default/google-chrome >/dev/null
apt-get update && apt-get upgrade -y
install_apt "google-chrome-stable" && echo -e "\n${R} [${W}-${R}]${C} Google Chrome sucessfully installed!${W}" || echo -e "\n❌${R} Google Chrome Installation failed!${W}"
  }
}

rem_theme() {
  theme=(Bright Daloa Emacs Moheli Retro Smoke)
  for rmi in "${theme[@]}"; do
  type -p "$rmi" &>/dev/null || {
  rm -rf /usr/share/themes/"$rmi" >/dev/null 2>&1
  }
done
}

rem_icon() {
  fonts=(hicolor LoginIcons ubuntu-mono-light)
  for rmf in "${fonts[@]}"; do
  type -p "$rmf" &>/dev/null || {
  rm -rf /usr/share/icons/"$rmf" >/dev/null 2>&1
  }
  done
}


config() {
  banner
  apt upgrade -y
  theme_packs=(
  gtk2-engines-murrine
  gtk2-engines-pixbuf
  sassc
  optipng
  libglib2.0-dev-bin
  libxml2-utils
  adwaita-icon-theme-full
  hicolor-icon-theme
  fonts-dejavu
  fonts-dejavu-core
  fonts-liberation
  fonts-freefont-ttf
  ncurses-term
  hunspell-en-us
  dictionaries-common
  )
apt install -y --no-install-recommends "${theme_packs[@]}"
  banner
echo -e "\n${R} [${W}-${R}]${C} Purging Unnecessary Files..\n${W}"
   rm -rf /usr/share/backgrounds >/dev/null 2>&1
sleep 1
   rm -rf /usr/share/backdrops/xfce/ >/dev/null 2>&1
sleep 1
   rm -rf /usr/share/xfce4/backdrops/ >/dev/null 2>&1
sleep 1
   rm -rf /usr/share/plank/themes >/dev/null 2>&1
sleep 1
   rm -rf /usr/share/sounds >/dev/null 2>&1
sleep 1
   rm -rf "/home/$user/.config" >/dev/null 2>&1
sleep 1
   mkdir -p /home/$user/Desktop
sleep 1
   mkdir -p /root/Desktop
sleep 1
   cp -r $term/../home/Storage /home/$user/
sleep 1
   rem_theme
   rem_icon
   echo -e "\n${R} [${W}-${R}]${C} Upgrading the System..\n${W}"
   apt update -y && apt upgrade -y
   apt clean -y
   apt autoremove -y

}

install_menu() {
    banner
    cat << EOF
        ${Y} ---${G} Select Software to Install (Multiple Allowed) ${Y}---

        ${C} [${W}1${C}] Firefox
        ${C} [${W}2${C}] BlueJ
        ${C} [${W}3${C}] VLC Media Player
        ${C} [${W}4${C}] VS Code
        ${C} [${W}5${C}] Google Chrome

        ${Y} Example:${G} 2 3 5
EOF

    read -p "${R} [${G}~${R}]${Y} Enter choices: ${G}" choices
    echo

    for opt in $choices; do
        case $opt in
            1)
                install_firefox
                ;;
            2)
                install_bluej
                ;;
            3)
                apt install vlc -y
                ;;
            4)
                install_vscode
                ;;
                
            5)  install_chrome
                ;;
                
            *)
                echo -e "${R} Invalid option: $opt${W}"
                ;;
        esac
    done
}

programming_menu() {
banner
cat << EOF

${Y} ---${G} Select Programming Languages to Install for VS Code (Multiple Allowed) ${Y}---

${C} [${W}1${C}] Java (JDK)
${C} [${W}2${C}] Python
${C} [${W}3${C}] C
${C} [${W}4${C}] C++
${C} [${W}5${C}] C#
${C} [${W}6${C}] Node.js / JavaScript
${C} [${W}7${C}] HTML/CSS Tools
${C} [${W}8${C}] PHP
${C} [${W}9${C}] Go
${C} [${W}10${C}] Rust

${Y} Example:${G} 1 2 3 4

EOF

read -p "${R} [${G}~${R}]${Y} Enter choices: ${G}" hh
echo

for ht in $hh; do
    case $ht in

        1)
            echo -e "${G}Installing Java...${W}"
            install_apt "openjdk-25-jdk"
            ;;

        2)
            echo -e "${G}Installing Python...${W}"
            install_apt "python3"
            install_apt "python3-pip"
            ;;

        3)
            echo -e "${G}Installing C Compiler...${W}"
            install_apt "gcc"
            ;;

        4)
            echo -e "${G}Installing C++ Compiler...${W}"
            install_apt "g++"
            ;;

        5)
            echo -e "${G}Installing C#...${W}"
            install_apt "mono-complete"
            ;;

        6)
            echo -e "${G}Installing Node.js...${W}"
            install_apt "nodejs"
            install_apt "npm"
            ;;

        7)
            echo -e "${G}Installing HTML/CSS Tools...${W}"
            install_apt "nodejs"
            install_apt "npm"
            command -v npm >/dev/null 2>&1 && npm install -g live-server
            ;;

        8)
            echo -e "${G}Installing PHP...${W}"
            install_apt "php"
            ;;

        9)
            echo -e "${G}Installing Go...${W}"
            install_apt "golang-go"
            ;;

        10)
            echo -e "${G}Installing Rust...${W}"
            curl https://sh.rustup.rs -sSf | sh -s -- -y
            ;;

        *)
            echo -e "${R}Invalid option: $ht${W}"
            ;;

    esac
done

}

thememenu() {
banner
cat << EOF

${Y} ---${G} Select Theme to Install for Desktop  (Only one Allowed) ${Y}---

${C} [${W}1${C}] macOS Sonoma Classic Theme (Default)
${C} [${W}2${C}] macOS Tahoe Classic Theme
${C} [${W}3${C}] Windows 11 Dark Theme
${C} [${W}4${C}] Windows 11 Light Theme

${Y} Example:${G} 1

EOF

read -n1 -p "${R} [${G}~${R}]${Y} Enter choices: ${G}" themenu
echo

if [[ ${themenu} == 2 ]]; then
   mactahoe
elif [[ ${themenu} == 3 ]]; then
  windark
elif [[ ${themenu} == 4 ]]; then
  winlight
else
  macclassic
fi

 }

mactahoe() {
   echo -e "\n${R} [${W}-${R}]${C} Installing icons and themes..\n${W}"
sleep 1
  apt install plank -y --no-install-recommends >/dev/null 2>&1
sleep 1
  echo -e "\n${R} [${W}-${R}]${C} Downloading theme archive...${W}"
  wget -qO "$term"/../home/UbuntuX/patches/macthemes.tar.gz https://github.com/techydude-ubuntux/UbuntuX/releases/download/v1.1/macthemes.tar.gz
sleep 1
   echo -e "\n${R} [${W}-${R}]${C} Extracting theme archive...${W}"
   tar --overwrite -xzf $term/../home/UbuntuX/patches/macthemes.tar.gz -C / || echo -e "\n${R}❌ Icon and Theme Installation failed!${W}\n"
sleep 1
   echo -e "\n${R} [${W}-${R}]${C} Applying theme config...${W}"
   tar --overwrite -xzf $term/../home/UbuntuX/patches/tahoeconfig.tar.gz -C /home/$user/ || echo -e "\n${R}❌ Config Installation failed!${W}\n"
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Rebuilding Font Cache..\n${W}"
fc-cache -fv >/dev/null 2>&1
sleep 1
dbus-launch plank >/dev/null 2>&1 &
sleep 1
 }

macclassic() {
  echo -e "\n${R} [${W}-${R}]${C} Installing icons and themes..\n${W}"
sleep 1
  apt install plank -y --no-install-recommends >/dev/null 2>&1
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Downloading theme archive...${W}"
  wget -qO "$term"/../home/UbuntuX/patches/macthemes.tar.gz https://github.com/techydude-ubuntux/UbuntuX/releases/download/v1.1/macthemes.tar.gz
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Extracting theme archive...${W}"
   tar --overwrite -xzf $term/../home/UbuntuX/patches/macthemes.tar.gz -C / || echo -e "\n${R}❌ Icon and Theme Installation failed!${W}\n"
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Applying theme config...${W}"
   tar --overwrite -xzf $term/../home/UbuntuX/patches/macclconfig.tar.gz -C /home/$user/ || echo -e "\n${R}❌ Config Installation failed!${W}\n"
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Rebuilding Font Cache..\n${W}"
fc-cache -fv >/dev/null 2>&1
sleep 1
dbus-launch plank >/dev/null 2>&1 &
sleep 1
 }

windark() {
 echo -e "\n${R} [${W}-${R}]${C} Installing icons and themes..\n${W}"
sleep 1
  apt install xfce4-docklike-plugin  -y --no-install-recommends >/dev/null 2>&1
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Downloading theme archive...${W}"
  wget -qO "$term"/../home/UbuntuX/patches/winthemes.tar.gz https://github.com/techydude-ubuntux/UbuntuX/releases/download/v1.1/winthemes.tar.gz
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Extracting theme archive...${W}"
tar --overwrite -xzf $term/../home/UbuntuX/patches/winthemes.tar.gz -C / || echo -e "\n${R}❌ Icon and Theme Installation failed!${W}\n"
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Applying theme config...${W}"
tar --overwrite -xzf $term/../home/UbuntuX/patches/winconfigd.tar.gz -C /home/$user/ || echo -e "\n${R}❌ Config Installation failed!${W}\n"
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Rebuilding Font Cache..\n${W}"
fc-cache -fv >/dev/null 2>&1
sleep 1
 }

winlight() {
 echo -e "\n${R} [${W}-${R}]${C} Installing icons and themes..\n${W}"
sleep 1
  apt install xfce4-docklike-plugin  -y --no-install-recommends >/dev/null 2>&1
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Downloading theme archive...${W}"
  wget -qO "$term"/../home/UbuntuX/patches/winthemes.tar.gz https://github.com/techydude-ubuntux/UbuntuX/releases/download/v1.1/winthemes.tar.gz
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Extracting theme archive...${W}"
tar --overwrite -xzf $term/../home/UbuntuX/patches/winthemes.tar.gz -C / || echo -e "\n${R}❌ Icon and Theme Installation failed!${W}\n"
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Applying theme config...${W}"
tar --overwrite -xzf $term/../home/UbuntuX/patches/winconfigl.tar.gz -C /home/$user/ || echo -e "\n${R}❌ Config Installation failed!${W}\n"
sleep 1
echo -e "\n${R} [${W}-${R}]${C} Rebuilding Font Cache..\n${W}"
fc-cache -fv >/dev/null 2>&1
sleep 1
 }

 blicon() {
 sleep 1
 rm -rf /usr/share/pixmaps/bluej.xpm /usr/share/icons/hicolor/256x256/apps/bluej.png /usr/share/icons/hicolor/48x48/apps/bluej.png >/dev/null 2>&1
 sleep 1
 rm -rf /root/.config/
 sleep 1
 cp -r /home/$user/.config /root/
 sleep 1
 orphan="/usr/share/applications"
 dpkg -s bluej >/dev/null 2>&1 || rm -f "$orphan/bluej.desktop"
 dpkg -s code >/dev/null 2>&1 || {
        rm -f "$orphan/code.desktop"
        rm -f "$orphan/code-url-handler.desktop"
    }

    dpkg -s firefox >/dev/null 2>&1 || rm -f "$orphan/firefox.desktop"
    dpkg -s gucharmap >/dev/null 2>&1 || rm -f "$orphan/gucharmap.desktop"
    dpkg -s mate-calc >/dev/null 2>&1 || rm -f "$orphan/mate-calc.desktop"
    dpkg -s onboard >/dev/null 2>&1 || rm -f "$orphan/onboard.desktop"
    dpkg -s openjdk-25-jdk >/dev/null 2>&1 || rm -f "$orphan/openjdk-25-java.desktop"
    dpkg -s plank >/dev/null 2>&1 || rm -f "$orphan/plank.desktop"
    dpkg -s python3 >/dev/null 2>&1 || rm -f "$orphan/python3.13.desktop"
    dpkg -s vlc >/dev/null 2>&1 || rm -f "$orphan/vlc.desktop"
 }

UBUNTU_DIR="/data/data/com.termux/files/usr/var/lib/proot-distro/containers/ubuntu/rootfs"
note() {
    if [ -d "$UBUNTU_DIR" ]; then
    banner
    echo -e "${C}"
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║              UbuntuX Setup Completed 🚀              ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo -e "${W}"

    echo -e "${G}✓ Ubuntu Installation Completed Successfully!${W}"
    echo

    echo -e "${Y}➜ Start Ubuntu:${W}   ${G}UbuntuX${W}"
    echo -e "${Y}➜ Exit Ubuntu:${W}    ${G}logout${W}"
    echo

    echo -e "${R}Important Notes:${W}"
    echo -e "${W}• Use only:${G} UbuntuX ${W}to start Ubuntu!"
    echo -e "${W}• Do NOT use:${R} proot-distro login ubuntu!${W}"
    echo -e "${W}• Customize Termux-X11 display settings as preferred on Github."
    echo -e "${W}• Paste the keyboard config below in Termux:X11!"
    echo

    echo -e "${C}━━━━━━━━━━━ Termux:X11 Extra Keys ━━━━━━━━━━━${W}"
    echo

    cat << 'EOF'

 [['F1','F2','F3','F4','F5','F6','F7','F8','F9'],
 ['F10','F11','F12','HOME','END','TAB','ALT','CTRL','SHIFT'],
 ['UP','DOWN','LEFT','RIGHT','PGUP','PGDN','ESC','PREFERENCES','KEYBOARD']]

EOF

    echo -e "${Y}How to apply:${W}"
    echo -e "${W}1.${G} Open Termux:X11"
    echo -e "${W}2.${G} Settings → Extra Keys Config"
    echo -e "${W}3.${G} Copy-paste the above block"
    echo -e "${W}4.${G} Save and restart Termux:X11"
    echo

    echo -e "${C}══════════════════════════════════════════════════════${W}"
    else
    echo -e "\n${R}❌ Ubuntu installation failed!${W}"
    exit 1
    fi
}


#-----functions-----#
banner
sudo
login
package
install_menu
programming_menu
config
thememenu
blicon
note
