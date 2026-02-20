# 🛠️ Workstation Starter Kit

[![Last Commit](https://img.shields.io/github/last-commit/KernelChief/alma-driver-manager)](https://github.com/KernelChief/alma-driver-manager/commits)
[![Repo Size](https://img.shields.io/github/repo-size/KernelChief/alma-driver-manager)](https://github.com/KernelChief/alma-driver-manager)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![Python](https://img.shields.io/badge/Made%20with-Python-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![Shell](https://img.shields.io/badge/Script-Shell-4EAA25?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Fedora](https://img.shields.io/badge/Platform-Fedora%2043%20KDE-51A2DA?logo=fedora&logoColor=white)](https://fedoraproject.org/)
[![Buy Me A Coffee](https://img.shields.io/badge/Support-Buy%20Me%20A%20Coffee-orange?logo=buy-me-a-coffee)](https://www.buymeacoffee.com/ttheroux)
[![Stars](https://img.shields.io/github/stars/KernelChief/alma-driver-manager?style=social)](https://github.com/KernelChief/alma-driver-manager/stargazers)

A small, opinionated GTK application for **Fedora 43 KDE** that provides one-click setup for workstation tools, gaming utilities, and common desktop apps.

The UI runs unprivileged and system changes are done through a **polkit-protected helper**.

---

## 📚 Quick Navigation

- [🚀 Quick Start](#-quick-start-recommended)
- [📦 Installation Methods](#-installation-methods)
- [🧩 Supported Platform](#-supported-platform)
- [🧰 Included Features](#-included-features)
- [🔐 Privilege & Security Model](#-privilege--security-model)
- [🛠️ Build RPM](#️-build-rpm)
- [❓ FAQ](#-faq)
- [📜 License](#-license)

---

## 🚀 Quick Start (Recommended)

### 1️⃣ Download the RPM

Go to the project releases page:

https://github.com/KernelChief/alma-driver-manager/releases

Download the RPM named like:

- `workstation-starter-kit-X.X.X-X.fc43.noarch.rpm`

Where:

- `X.X.X` = app version
- `-X` = RPM release number

---

### 2️⃣ Install the RPM

From the directory where the file was downloaded:

```bash
sudo dnf install ./workstation-starter-kit-X.X.X-X.fc43.noarch.rpm
```

This installs:

- the GUI launcher (`workstation-starter-kit`)
- the helper (`/usr/libexec/workstation-starter-kit-helper`)
- the polkit policy
- the desktop entry

---

### 3️⃣ Launch the App

Launch from app menu:

- **Workstation Starter Kit**

Or via terminal:

```bash
workstation-starter-kit
```

---

## 📦 Installation Methods

Depending on feature, Workstation Starter Kit uses:

- DNF package installs/removals
- Official URL RPM installs (e.g. Chrome, Zoom)
- Flatpak installs (user or system scope)
- COPR enable + package install for selected tools
- Service enable/disable via `systemctl`
- System config actions (e.g. ZRAM profile, SELinux mode)

---

## 🧩 Supported Platform

- **Primary target:** Fedora 43 KDE Workstation
- **Best effort:** Other RPM-based distributions using `dnf`

---

## 🧰 Included Features

Includes install/remove workflows for:

- Essential and Monitoring setup bundles
- SELinux helper flow (including enforcing → permissive/disabled prompt)
- ZRAM profile
- 1Password, Proton Pass, Tailscale
- Gaming stack (Steam, Lutris, Wine, GameMode, Gamescope, MangoHud, GOverlay, etc.)
- Utility/media apps (OBS Studio, VLC, Btrfs Assistant, Distrobox, Chrome, Zoom)
- Flatpak apps (Spotify, LibreOffice, Discord, Slack, Mattermost, Boxflat, BoxBuddy)

The in-app list is the source of truth.

---

## 🔐 Privilege & Security Model

- GUI process runs as normal user
- Privileged actions are routed through:
  - `pkexec /usr/libexec/workstation-starter-kit-helper ...`
- Polkit action:
  - `org.workstationstarterkit.manager`
- Authentication is requested only when needed

---

## 🛠️ Build RPM

Prerequisites:

```bash
sudo dnf install -y rpm-build rpmdevtools rsync tar python3-gobject gtk3 polkit
rpmdev-setuptree
```

Build v1.0.0 example:

```bash
./src/packaging/build-rpm.sh 1.0.0
```

Output:

- `~/rpmbuild/RPMS/noarch/workstation-starter-kit-1.0.0-1.fc43.noarch.rpm`
- `~/rpmbuild/SRPMS/workstation-starter-kit-1.0.0-1.fc43.src.rpm`

---

## ❓ FAQ

**Why does it ask for admin credentials?**  
Installing/removing packages, editing system config, and enabling services require elevated privileges.

**Does the app itself run as root?**  
No. The UI is unprivileged; only helper actions are elevated through polkit.

**Can I apply items one-by-one instead of bundles?**  
Yes. Every listed feature/app can be installed or removed individually.

**What if I only want Flatpak apps?**  
You can install only Flatpak rows; each prompts for user/system scope.

---

## 🤝 Community

- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Contributing](CONTRIBUTING.md)

---

## 📜 License

This project is licensed under the **GNU GPL v3.0**. See [LICENSE](LICENSE).
