#!/bin/bash

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
B="$(printf '\033[1;34m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"

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

arch=$(uname -m)
term="/data/data/com.termux/files/usr"

sudo() {
echo -e "\n${R} [${W}-${R}]${C} Installing Sudo...${W}"
apt update -y && apt upgrade -y
apt install sudo -y
apt install wget apt-utils locales-all dialog tzdata -y
echo -e "\n${R} [${W}-${R}]${G} Sudo Successfully Installed !${W}"
}

login() {
banner
read -p $' \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Input Username [Lowercase only & No Spaces] : \e[0m\e[1;96m\en' user
echo -e "${W}"
read -p $' \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Input Password : \e[0m\e[1;96m\en' pass
echo -e "${W}"
useradd -m -s $(which bash) ${user}
usermod -aG sudo ${user}
echo "${user}:${pass}" | chpasswd
echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

cat > $term/bin/UbuntuX << EOF
#!/data/data/com.termux/files/usr/bin/bash

kill -9 \$(pgrep -f "termux.x11") >/dev/null 2>&1
kill -9 \$(pgrep -f "virgl") >/dev/null 2>&1
kill -9 \$(pgrep -f "pulseaudio") >/dev/null 2>&1

{ virgl_test_server_android & } >/dev/null 2>&1

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

export XDG_RUNTIME_DIR=\${TMPDIR}
termux-x11 :0 -ac >/dev/null 2>&1 &
sleep 3

am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1
sleep 1

proot-distro login  --user $user ubuntu --bind /dev/null:/proc/sys/kernel/cap_last_last --shared-tmp --fix-low-ports

exit 0
EOF

chmod +x $term/bin/UbuntuX

cat >> /home/"$user"/.bashrc << 'EOF'
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax)
    export DBUS_SESSION_BUS_ADDRESS
fi

{ rm -rf .cache
export PULSE_SERVER=127.0.0.1
export GALLIUM_DRIVER=virpipe
export MESA_GL_VERSION_OVERRIDE=3.0
export MESA_GLES_VERSION_OVERRIDE=3.0
unset vblank_mode
export DISPLAY=:0
dbus-launch --exit-with-session xfce4-session & } >/dev/null 2>&1
EOF

chown "$user:$user" /home/"$user"/.bashrc

cat >> /home/"$user"/.bash_logout << 'EOF'
kill -9 $(pgrep -f "termux.x11") >/dev/null 2>&1
kill -9 $(pgrep -f "virgl") >/dev/null 2>&1
kill -9 $(pgrep -f "pulseaudio") >/dev/null 2>&1
EOF

chown "$user:$user" /home/"$user"/.bash_logout

}

package() {
   banner
   rm /var/lib/dpkg/info/udisks2.postinst
   echo "" > /var/lib/dpkg/info/udisks2.postinst
   dpkg --configure -a
   apt-mark hold udisks2
   apt purge --autoremove -y
   yes | apt update
   yes | apt upgrade
   echo -e "${R} [${W}-${R}]${C} Checking required packages...${W}"
   packs=(gnupg2 curl nano git xz-utils at-spi2-core xfce4 xfce4-terminal librsvg2-common menu inetutils-tools dialog exo-utils  dbus-x11 gtk2-engines-murrine gtk2-engines-pixbuf apt-transport-https glmark2 mesa-utils sl fastfetch mousepad ristretto xfce4-screenshooter )
   for a in "${packs[@]}"; do
   type -p "$a" &>/dev/null || {
   echo -e "\n${R} [${W}-${R}]${G} Installing package : ${Y}$hulu${W}"
   apt-get install "$a" -y --no-install-recommends
  }
done
  apt purge --autoremove -y
  apt-get update -y
  apt-get upgrade -y
  apt purge --autoremove -y
}

install_apt() {
  for apt in "$@"; do
  [[ `command -v $apt` ]] && echo -e "${Y}${apt} is already Installed!${W}" || {
   echo -e "\n${R} [${W}-${R}]${G} Installing package : ${Y}${apt}{W}"
   apt-get install ${apt} -y --no-install-recommends
}
  done
}

install_vscode() {
[[ $(command -v code) ]] && echo "${Y}VSCode is already Installed!${W}" || {
echo -e "${G}Installing ${Y}VS Code${W}"
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=arm64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
tee /etc/apt/preferences.d/vscode <<EOF
Package: code
Pin: origin packages.microsoft.com
Pin-Priority: 1001
EOF
apt update -y && apt upgrade -y
install_apt "code"
sleep 1
echo -e "${C} Visual Studio Code Installed Successfully\n${W}"
  }
}

install_firefox() {
[[ $(command -v firefox) ]] && echo "${Y}Firefox is already Installed!${W}\n" || {
echo -e "${G}Installing ${Y}Firefox${W}"
rm -f /etc/apt/sources.list.d/*mozilla* && rm -f /etc/apt/sources.list.d/*firefox*
apt install software-properties-common --no-install-recommends -y
add-apt-repository -y ppa:mozillateam
tee /etc/apt/preferences.d/mozilla-firefox <<EOF
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
apt update && apt upgrade -y
install_apt "firefox"
echo -e "${G} Firefox Installed Successfully\n${W}"
  }
}

install_bluej() {
wget -O "$term"/../home/UbuntuX/patches/BlueJ-linux-arm64-5.5.0.deb https://www.bluej.org/download/files/BlueJ-linux-arm64-5.5.0.deb
BLUEJ_FILE=$(ls "$term"/../home/UbuntuX/patches/BlueJ*.deb 2>/dev/null | head -n 1)

  if dpkg -s bluej >/dev/null 2>&1; then
  echo -e "${G}BlueJ is already installed!${W}\n"
  return 0
fi
  echo -e "${B}Installing ${Y}BlueJ${W}"
  if [ -z "$BLUEJ_FILE" ]; then
  echo -e "❌ No BlueJ .deb file found!"
  return 1
fi

    install_apt "openjdk-25-jdk"

    dpkg -i "$BLUEJ_FILE" || apt --fix-broken install -y
    sleep 1
    if dpkg -s bluej >/dev/null 2>&1; then
        echo -e "${G}BlueJ Installed Successfully${W}\n"
    else
        echo -e "❌ BlueJ installation failed!"
    fi
}

rem_theme() {
  theme=(Bright Daloa Emacs Moheli Retro Smoke)
  for rmi in "${theme[@]}"; do
  type -p "$rmi" &>/dev/null || {
  rm -rf /usr/share/themes/"$rmi"
  }
done
}

rem_icon() {
  fonts=(hicolor LoginIcons ubuntu-mono-light)
  for rmf in "${fonts[@]}"; do
  type -p "$rmf" &>/dev/null || {
  rm -rf /usr/share/icons/"$rmf"
  }
  done
}


config() {
  banner

apt upgrade -y
apt install gtk2-engines-murrine gtk2-engines-pixbuf sassc optipng libglib2.0-dev-bin alacarte onboard gucharmap mate-calc plank libxml2-utils -y --no-install-recommends

echo -e "${R} [${W}-${R}]${C} Downloading Required Files..\n${W}"
   rm -rf /usr/share/backgrounds
sleep 1
   rm -rf /usr/share/applications
sleep 1
   rm -rf /usr/share/backdrops/xfce/
sleep 1
   rm -rf /usr/share/xfce4/backdrops/
sleep 1
   echo -e "${R} [${W}-${R}]${C} Installing icons and themes..${W}"
sleep 1
   tar -xvpzf $term/../home/UbuntuX/patches/p.tar.gz -C / >/dev/null 2>&1
sleep 1
   tar -xzpvf $term/../home/UbuntuX/patches/config.tar.gz -C /home/$user/
sleep 1
   echo -e "${R} [${W}-${R}]${C} Purging Unnecessary Files..${W}"
   src="/usr/share/applications"

  FILES=( "panel-desktop-handler.desktop"
          "thunar-bulk-rename.desktop"
          "thunar.desktop"
          "xfce4-accessibility-settings.desktop"
          "xfce4-color-settings.desktop"
          "xfce4-mail-reader.desktop"
          "xfce4-run.desktop"
          "xfce4-session-logout.desktop"
          "xfce4-terminal-emulator.desktop"
          "xfce4-web-browser.desktop" )

   for file in "${FILES[@]}"; do
   echo "Deleting $file..."
   rm "$src/$file"
   done
   cp -r $term/../home/Storage /home/$user/
   rem_theme
   rem_icon

   echo -e "${R} [${W}-${R}]${C} Rebuilding Font Cache..\n${W}"
   fc-cache -fv

   echo -e "${R} [${W}-${R}]${C} Upgrading the System..\n${W}"
   apt update
   yes | apt upgrade
   apt clean
   yes | apt autoremove

dbus-launch plank >/dev/null 2>&1
}

install_menu() {
    banner
    cat << EOF
        ${Y} ---${G} Select Software to Install (Multiple Allowed) ${Y}---

        ${C} [${W}1${C}] Firefox
        ${C} [${W}2${C}] BlueJ
        ${C} [${W}3${C}] VLC Media Player
        ${C} [${W}4${C}] VS Code

        ${Y} Example: 1 2 3 4
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
                install_apt "vlc"
                ;;
            4)
                install_vscode
                ;;
            *)
                echo -e "${R} Invalid option: $opt${W}"
                ;;
        esac
    done
}

programming_menu() {

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

${Y} Example:${W} 1 2 3 4

EOF

read -p "${R}[${G}~${R}]${Y} Enter choices: ${G}" hh
echo

for ht in $hh; do
    case $ht in

        1)
            echo -e "${G}Installing Java...${W}"
            install_apt "openjdk-25-jdk"
            ;;

        2)
            echo -e "${G}Installing Python...${W}"
            install_apt "python3 python3-pip"
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
            sudo npm install -g  live-server
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
            echo -e "${R}Invalid option: $opt${W}"
            ;;

    esac
done

}

UBUNTU_DIR="/data/data/com.termux/files/usr/var/lib/proot-distro/containers/ubuntu/rootfs"
note() {
    if [ -d "$UBUNTU_DIR" ]; then
    banner
    echo -e "${C}"
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║              UbuntuX Setup Completed 🚀               ║"
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
    echo -e "${R}❌ Ubuntu installation failed!${W}"
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
note
