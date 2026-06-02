# UbuntuX 🚀

UbuntuX Lite is a lightweight and smooth Ubuntu XFCE desktop environment for Android built using Termux, Termux:X11, and Proot-Distro.

This project is created with the goal of making Linux and programming accessible to students and users who cannot afford a PC or laptop.

UbuntuX transforms an Android phone into a portable Linux desktop with:

> Features ✨

- 🚫 No root required
- ⚡ Hardware accelerated graphics
- 🎵 Audio support with PulseAudio
- 🖥️ Smooth Termux:X11 desktop
- 🍎 macOS styled theme and dock
- 🪟 Windows theme and taskbar 
- 💻 VS Code support
- ☕ BlueJ support for Java learners
- 🔥 Lightweight and optimized XFCE desktop
- ❌ No VNC required
- 📦 One-command installation

---

# Why UbuntuX? 🚀

> UbuntuX is designed for:
- Students
- Programmers (Java, Python, Web Development etc.)
- Programming on Android 
- Linux learning
- Users with low-end devices as well as high-end devices

The aim of UbuntuX is to provide a clean, fast, and easy Linux setup on Android so anyone can learn programming and use desktop Linux tools directly from their phone.

---

# Requirements
1. Android Phone
2. 6GB+ free Storage
3. Termux
4. Termux:X11
5. Phantom Process Fix if Android 12+(phantom-process-fix-important-)

---

# Install Required Apps 📥


## 1. Install Termux
https://github.com/termux/termux-app/releases/download/v0.118.3/termux-app_v0.118.3+github-debug_universal.apk

> Do NOT install Termux from Play Store because it is outdated.


## 2. Install Termux:X11
https://github.com/termux/termux-x11/releases/download/nightly/app-universal-debug.apk


## Install ADB AppControl App
https://adbappcontrol.com/en/mobile/

---

# Phantom Process Fix (IMPORTANT) ⚠️

Android 12+ kills Termux background processes using Phantom Process Killer.

This may cause:
- Signal 9 errors
- Termux getting killed in background
- XFCE suddenly closing
- VS Code crashing
- Audio stopping
- Ubuntu session randomly exiting

> You should apply this fix before using UbuntuX.

---

# Enable Required Android Settings

- Step 1: Open Settings → About Phone
- Step 2: Tap Build Number 7 times to enable Developer Options
- Step 3: Connect to Wifi and turn on USB Debugging and Wireless Debugging
- Step 3: Open The app and do the setup as directed in app.
- Step 4: After connecting Open the: Applications Menu beside three dots and open console!
- Step 5: Copy-paste this command and press Enter.
```bash
/system/bin/device_config put activity_manager max_phantom_processes 10000
```

#### After running the command:
> You can turn off Developer Options, Wireless Debugging, USB Debugging
  and uninstall **ADB App Control App**
 
---

# Installation 🚀

## Setup Storage
```bash
termux-setup-storage
```
```bash
mv ~/storage/shared ~
```
```bash
rm -rf ~/storage
```
```bash
mv shared Storage
```

## Clone UbuntuX Repository

```bash
yes | pkg up
```
```bash
pkg install git -y
```
```bash
git clone https://github.com/techydude-ubuntux/UbuntuX.git
```
```bash
bash ~/UbuntuX/setup.sh
```

---

## What The Installer Does 🛠️

The setup script automatically:

✅ Installs Ubuntu using Proot-Distro  
✅ Installs XFCE desktop  
✅ Configures audio  
✅ Configures hardware acceleration  
✅ Installs themes and icons  
✅ Configures desktop environment  
✅ Sets up Linux user account  

---

# During Installation 👤


UbuntuX will ask you to create:


## Linux Username

```text
Enter Your Name or username of any choice in small letters without any spaces and without special symbols!
```

## Linux Password

```text
Enter Password of your choice!
```

The installer automatically:
- Creates your Linux account
- Adds sudo support
- Configures startup files

---

# Software Installation 📦

UbuntuX allows installing additional software during setup. You can install one or multiple apps during setup.


Menu:

| Option | Software |
|---|---|
| 1 | Firefox |
| 2 | VS Code |
| 3 | BlueJ |
| 4 | VLC |

Example:

```text
Enter choices: 1 2 3 4
```

This installs all apps :
- Firefox
- VS Code
- BlueJ
- VLC

## Time Zone Configuration

During installation, Ubuntu may ask you to configure time zone and region after installion of `tzdata`.

Select:
- Region: `Your Continent`
- Timezone: `Your City or Timezone of Your country`

Controls:
- ↑ ↓ → Navigate
- `SPACEBAR` → Select/Confirm
- `TAB` → Move to `<OK>`
- `ENTER` → Continue

> After confirming, installation will continue automatically.

# Programming Languages Support 👨‍💻

UbuntuX also supports multiple programming languages and development environments.

You can install one or multiple languages during setup.


| Option | Programming Language |
|---|---|
| 1 | Java |
| 2 | Python |
| 3 | C |
| 4 | C++ |
| 5 | C# |
| 6 | JavaScript / Node.js |
| 7 | HTML / CSS |
| 8 | PHP |
| 9 | Go |
| 10 | Rust |

Example:

```text
Enter choices: 1 2 3 4 5 6 7 8 9 10
```

> This installs all languages.

- UbuntuX provides a lightweight Linux development environment for learning, coding, compiling, and running programs directly on Android using Termux and Proot.

# Desktop Theme Support 🎨

UbuntuX provides multiple desktop themes and visual styles.

You can install **only one theme** during setup.

| Option | Desktop Theme |
|---------|--------------|
| 1 | macOS Sonoma Classic Theme (Default) |
| 2 | macOS Tahoe Classic Theme |
| 3 | Windows 11 Dark Theme |
| 4 | Windows 11 Light Theme |

Example:

```text
Enter choice: 1
```
> This installs the macOS Sonoma Classic Theme.

### Theme Features

- **macOS Sonoma Classic Theme**
  - macOS-style desktop layout
  - Plank Dock
  - macOS icons and themes

- **macOS Tahoe Classic Theme**
  - Tahoe-inspired macOS appearance
  - Plank Dock
  - Modern macOS icons and themes

- **Windows 11 Dark Theme**
  - Windows 11 dark appearance
  - XFCE Docklike Panel
  - Windows-style icons and layout

- **Windows 11 Light Theme**
  - Windows 11 light appearance
  - XFCE Docklike Panel
  - Windows-style icons and layout

- UbuntuX automatically installs required icons, themes, fonts, and desktop configurations.
- Font cache is rebuilt automatically after installation.
- Only one desktop theme can be selected during setup.

---

# Starting UbuntuX ▶️

> To launch UbuntuX

- Type in Termux:
```bash
UbuntuX
```
It will launch the desktop environment.

---

# Exit UbuntuX

> To close UbuntuX:

- Type in Termux (only):
```bash
logout
```

---

# VS Code Fix 🛠️

> If VS Code does not launch correctly
- Do right click on VS code and paste this in command section:

```bash
code --no-sandbox
```

---

# Termux:X11 Recommended Settings ⚙️

Open:

```text
Termux:X11 → Preferences
```

### Output
- Resolution Mode → `Custom`
- Resolution → `1080x1200`
- Filtering Mode → `Bilinear`
- Adjust resolution to orientation → `OFF`
- Stretch to fit display → `OFF`
- Reseed screen while keyboard open → `ON`
- PIP Mode → `OFF`
- Immersive Mode → `ON`
- Screen Orientation → `Auto`
- Hide display cutout → `ON`
- Keep Screen On → `ON`

### Pointer
- Apply display scale factor to touchpad → `OFF`

---

### Keyboard
- Show additional keyboard → `ON`
- Show keyboard with additional keys → `ON`
- Show IME with external keyboard → `OFF`
- Prefer scancodes when possible → `ON`
- Hardware keyboard scancodes workaround → `ON`

---

# Termux:X11 Extra Keyboard ⌨️

Open:
```text
Termux:X11 → Settings → Extra Keys Config
```

Paste:

```bash
[['F1','F2','F3','F4','F5','F6','F7','F8','F9'],
['F10','F11','F12','HOME','END','TAB','ALT','CTRL','SHIFT'],
['UP','DOWN','LEFT','RIGHT','PGUP','PGDN','ESC','PREFERENCES','KEYBOARD']]
```

Save the preferences!

### Extra Key Bar Opacity → `50`

---

### Gestures
> In other tab of X11
- Three finger swipe up → Toggle soft keyboard
- Three finger swipe down → Toggle extra key bar

---

### Important
Disable these Android gestures:
- Three finger screenshot
- Three finger split screen

These may conflict with Termux:X11 gestures.

---

# Performance Tips ⚡

For best performance:

- Disable battery optimization for:
  - Termux
  - Termux:X11

- Keep at least:
  - 2GB of free RAM
  - 6GB of free storage

- Use Android dark mode
- Avoid aggressive battery saver modes

---

# Screenshots 📸

## Desktop
![s1](Screenshots/s1.jpg)
## macOS Theme & Dock
![s2](Screenshots/s2.jpg)
![s3](Screenshots/s3.jpg)
## Installed Apps (VS Code, Firefox, VLC, etc.)
![s4](Screenshots/s4.jpg)
## Utilities 
![s6](Screenshots/s6.jpg)
![s7](Screenshots/s7.jpg)
## About OS
![s5](Screenshots/s5.jpg)
  
---

# Credits ❤️

Projects used:
- Termux
- Termux:X11
- Proot-Distro
- Mesa

---

# Note:
Performance depends on:
- Device CPU
- RAM
- Android version

> Some applications may behave differently compared to real Linux systems.

---

# License 📜

MIT License
