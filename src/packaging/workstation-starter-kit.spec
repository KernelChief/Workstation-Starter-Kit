# SPDX-License-Identifier: GPL-3.0-or-later

Name:           workstation-starter-kit
%{!?app_version:%global app_version 1.0}
Version:        %{app_version}
Release:        1%{?dist}
Summary:        Simple GTK bootstrap assistant for RPM workstations
License:        GPL-3.0-or-later
URL:            https://github.com/KernelChief/workstation-starter-kit
BuildArch:      noarch

Requires:       python3
Requires:       python3-gobject
Requires:       gtk3
Requires:       polkit
Requires:       coreutils
Requires:       curl
Requires:       systemd
Requires:       dnf

Source0:        workstation-starter-kit-%{version}.tar.gz

%description
Workstation Starter Kit is a simple GTK utility for RPM-based distributions.
It provides one-click install/remove actions for workstation bootstrap tasks
using a PolicyKit-protected helper.

%prep
%setup -q

%install
rm -rf %{buildroot}

install -D -m 0755 src/workstation-starter-kit %{buildroot}%{_bindir}/workstation-starter-kit
install -D -m 0755 src/workstation-starter-kit-helper %{buildroot}%{_libexecdir}/workstation-starter-kit-helper
install -D -m 0644 src/org.workstationstarterkit.manager.policy \
  %{buildroot}%{_datadir}/polkit-1/actions/org.workstationstarterkit.manager.policy
install -D -m 0644 src/workstation-starter-kit.desktop \
  %{buildroot}%{_datadir}/applications/workstation-starter-kit.desktop
install -D -m 0644 LICENSE \
  %{buildroot}%{_datadir}/licenses/%{name}/LICENSE

%files
%{_bindir}/workstation-starter-kit
%{_libexecdir}/workstation-starter-kit-helper
%{_datadir}/polkit-1/actions/org.workstationstarterkit.manager.policy
%{_datadir}/applications/workstation-starter-kit.desktop
%{_datadir}/licenses/%{name}/LICENSE

%changelog
* Thu Feb 19 2026 KernelChief - 1.0-1
- Rename to Workstation Starter Kit and simplify app/helper flow
