# SPDX-License-Identifier: GPL-3.0-or-later

Name:           linux-starter-kit
%{!?app_version:%global app_version 1.0}
Version:        %{app_version}
Release:        1%{?dist}
Summary:        Creative-style onboarding GUI for RPM distributions
License:        GPL-3.0-or-later
URL:            https://github.com/KernelChief/linux-starter-kit
BuildArch:      noarch

Requires:       python3
Requires:       python3-gobject
Requires:       gtk3
Requires:       polkit
Requires:       coreutils
Requires:       curl
Requires:       systemd
Requires:       dnf

Source0:        linux-starter-kit-%{version}.tar.gz

%description
Linux Starter Kit is a GTK utility for RPM-based distributions that applies
a workstation bootstrap profile (repositories, packages, flatpaks, zram, and
services) through a PolicyKit-protected helper.

%prep
%setup -q

%install
rm -rf %{buildroot}

# App
install -D -m 0755 src/linux-starter-kit %{buildroot}%{_bindir}/linux-starter-kit

# Root helper
install -D -m 0755 src/linux-starter-kit-helper %{buildroot}%{_libexecdir}/linux-starter-kit-helper

# Polkit policy
install -D -m 0644 src/org.linuxstarterkit.manager.policy \
  %{buildroot}%{_datadir}/polkit-1/actions/org.linuxstarterkit.manager.policy

# Desktop entry
install -D -m 0644 src/linux-starter-kit.desktop \
  %{buildroot}%{_datadir}/applications/linux-starter-kit.desktop

# License
install -D -m 0644 LICENSE \
  %{buildroot}%{_datadir}/licenses/%{name}/LICENSE

%files
%{_bindir}/linux-starter-kit
%{_libexecdir}/linux-starter-kit-helper
%{_datadir}/polkit-1/actions/org.linuxstarterkit.manager.policy
%{_datadir}/applications/linux-starter-kit.desktop
%{_datadir}/licenses/%{name}/LICENSE

%changelog
* Thu Feb 19 2026 KernelChief - 1.0-1
- Rebrand and rebuild as Linux Starter Kit
