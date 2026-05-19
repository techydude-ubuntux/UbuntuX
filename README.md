# UbuntuX 🚀

UbuntuX is a lightweight and smooth Ubuntu XFCE desktop environment for Android built using Termux, Termux:X11, and Proot-Distro.

This project is created by **Shivansh Joshi (14 years old programmer)** with the goal of making Linux and programming accessible to students and users who cannot afford a PC or laptop.

UbuntuX transforms an Android phone into a portable Linux desktop with:
- Features ✨

- 🚫 No root required
- ⚡ Hardware accelerated graphics
- 🎵 Audio support with PulseAudio
- 🖥️ Smooth Termux:X11 desktop
- 🍎 macOS styled theme and dock
- 💻 VS Code support
- ☕ BlueJ support for Java learners
- 🔥 Lightweight and optimized XFCE desktop
- ❌ No VNC required
- 📦 One-command installation

---

UbuntuX is designed for:
- Students
- Programmers(Java, Python, Web Development etc.)
- Java learners
- Linux enthusiasts
- Users with low-end devices

The aim of UbuntuX is to provide a clean, fast, and easy Linux setup on Android so anyone can learn programming and use desktop Linux tools directly from their phone.

# Why UbuntuX? 🚀

UbuntuX is designed for:
- Programming on Android 
- Java development
- Web development
- Linux learning
- Lightweight desktop

Advantages:
- Better performance than VNC desktops
- Cleaner macOS-like interface
- Hardware accelerated rendering
- Easy installation process
- Smooth desktop experience on Android

---

# Desktop Environment 🖥️

UbuntuX uses:
- XFCE4 Desktop
- Custom macOS inspired theme
- Plank Dock
- Optimized lightweight configuration

This provides:
- Lower RAM usage
- Better responsiveness
- Smooth animations
- Clean UI for programmers

---

# Programmer Friendly 👨‍💻

UbuntuX supports:
- VS Code
- BlueJ
- OpenJDK 17
- Git
- Nano
- Firefox
- VLC

Perfect for:
- Java learners
- Python beginners
- Linux users
- Web development

---

# Install Required Apps 📥

## 1. Install Termux

Download latest Termux apk (universal debug):

### GitHub
https://github.com/termux/termux-app/releases/download/v0.118.3/termux-app_v0.118.3+github-debug_universal.apk

> Do NOT install Termux from Play Store because it is outdated.

---

## 2. Install Termux:X11

Download latest Termux:X11 APK (universal debug):

### GitHub
https://github.com/termux/termux-x11/releases/download/nightly/app-universal-debug.apk

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

You should apply this fix before using UbuntuX.

---

# Fix Using Wireless ADB (No PC Required) 📱

## 3. Install ADB AppControl Mobile

Download:
https://adbappcontrol.com/en/mobile/

Install the app on your Android phone.

---

# Enable Required Android Settings

Open:

```text
Settings → About Phone
```

Tap:
```text
Build Number
```

7 times to enable Developer Options.

Now open:

```text
Settings → Developer Options
```

Enable:
- USB Debugging
- Wireless Debugging

---

# Connect ADB AppControl

## Step 1
```text
Open The app and do the setup as directed in app and pair using
pairing code in notification
```

## Step 2 After connecting:
Open the:
```text
⋮ Three Dots Menu and open console
```

## Step 4
Copy-paste this command:

```bash
/system/bin/device_config put activity_manager max_phantom_processes 10000
```

Then press Enter.

---

# Restart Your Phone 🔄

After running the command:
- You can turn off Developer Options, Wireless Debugging, USB Debugging
  and unimstall **ADB App Control App**
- Restart your device once
- Open Termux again
- UbuntuX will work properly now

---

# Installation 🚀

## Clone UbuntuX Repository

```bash
yes | pkg up 
pkg install git -y

git clone https://github.com/techydude-ubuntux/UbuntuX.git
cd UbuntuX

bash UbuntuX/setup.sh
```

---

# What The Installer Does 🛠️

The setup script automatically:

✅ Configures storage  
✅ Installs required repositories  
✅ Installs Ubuntu using Proot-Distro  
✅ Installs XFCE desktop  
✅ Configures audio  
✅ Configures hardware acceleration  
✅ Installs themes and icons  
✅ Creates the `ubuntux` startup command  
✅ Configures desktop environment  
✅ Sets up Linux user account  

---

# During Installation 👤

UbuntuX will ask you to create:

## Linux Username
Example:

```text
yourname
```

## Linux Password
Example:

```text
your password 
```

The installer automatically:
- Creates your Linux account
- Adds sudo support
- Configures startup files

---

# Optional Software Installation 📦

UbuntuX allows installing additional software during setup.

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
---

# Starting UbuntuX ▶️

After installation:

```bash
UbuntuX
```

UbuntuX automatically:
- Starts PulseAudio
- Starts Termux:X11
- Starts VirGL Hardware Acceleration 
- Launches XFCE desktop

---

# Exit UbuntuX

To close Ubuntu:

```bash
logout
```

---

# VS Code Fix 🛠️

If VS Code does not launch correctly 
Do right click on VS code and paste this in command section:

```bash
code --no-sandbox
```
---

# Included Applications 📦

UbuntuX includes:
- XFCE4
- Fastfetch
- Ristretto
- Firefox
- VS Code
- BlueJ
- VLC

---
## Termux:X11 Recommended Settings ⚙️

Open:

```text
Termux:X11 → Preferences
```

### Output
- Resolution Mode → `Custom`
- Resolution → `1080x1200`
- Filtering Mode → `Nearest`
- Adjust resolution to orientation → `OFF`
- Stretch to fit display → `OFF`
- Reseed screen while keyboard open → `ON`
- PIP Mode → `OFF`
- Immersive Mode → `ON`
- Screen Orientation → `Auto`
- Hide display cutout → `ON`
- Keep Screen On → `ON`

> Do NOT change pointer settings.

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

```text
[['F1','F2','F3','F4','F5','F6','F7','F8','F9'],
['F10','F11','F12','HOME','END','TAB','ALT','CTRL','SHIFT'],
['UP','DOWN','LEFT','RIGHT','PGUP','PGDN','ESC','PREFERENCES','KEYBOARD']]
```

Save the preferences!

### Extra Key Bar Opacity → `50`

---

### Gestures
- Three finger swipe up → Toggle soft keyboard
- Three finger swipe down → Toggle extra key bar

---

### Important
Disable these Android gestures:
- Three finger screenshot
- Three finger split screen

They may conflict with Termux:X11 gestures.


# Important Note ⚠️

Disable these Android gestures from your phone settings:
- Three finger screenshot
- Three finger split screen

Otherwise they may conflict with Term

---

# Performance Tips ⚡

For best performance:

- Disable battery optimization for:
  - Termux
  - Termux:X11

- Keep at least:
  - 2GB free RAM
  - 6GB free storage

- Use Android dark mode

- Avoid aggressive battery saver modes

---

# Screenshots 📸

- Desktop
- ![Desktop](Screenshots/s1.jpg)
- VS Code
- BlueJ
- macOS Theme & Dock

---

# Credits ❤️

Projects used:
- Termux
- Termux:X11
- XFCE
- Proot-Distro
- VirGL
- Mesa

---

# Note:
Performance depends on:
- Device CPU
- RAM
- Android version

Some applications may behave differently compared to real Linux systems.

---

# License 📜

MIT License
