#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail

NAME="workstation-starter-kit"
VERSION="${1:-1.0}"

# Keep normal release versions as provided (e.g. v1.0.0), but convert
# prerelease separator '-' to '~' for RPM compatibility/order.
# Example PR/dev: 0.0.0-beta.pr1.abcdef12 -> 0.0.0~beta.pr1.abcdef12
RPM_VERSION="${VERSION}"
if [[ "${RPM_VERSION}" == *-* ]]; then
  RPM_VERSION="${RPM_VERSION/-/~}"
fi

# Replace any other unsupported chars with '.' to avoid rpmbuild parse errors.
RPM_VERSION="$(printf '%s' "${RPM_VERSION}" | sed 's/[^[:alnum:]._+~]/./g')"

if [[ "${RPM_VERSION}" != "${VERSION}" ]]; then
  echo "Normalized VERSION for RPM: ${VERSION} -> ${RPM_VERSION}"
fi

# Ensure rpmbuild tree exists
command -v rpmdev-setuptree >/dev/null 2>&1 || {
  echo "ERROR: rpmdevtools not installed. Install: sudo dnf install rpmdevtools" >&2
  exit 1
}
rpmdev-setuptree >/dev/null 2>&1 || true

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SPEC="${ROOT_DIR}/src/packaging/${NAME}.spec"

if [[ ! -f "${SPEC}" ]]; then
  echo "ERROR: Spec not found: ${SPEC}" >&2
  exit 2
fi

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

SRC_DIR="${TMPDIR}/${NAME}-${RPM_VERSION}"
mkdir -p "${SRC_DIR}"

# Copy repo contents into tarball staging directory
# Exclude git + common junk
rsync -a \
  --exclude ".git" \
  --exclude ".github" \
  --exclude "*/__pycache__" \
  --exclude "*.pyc" \
  --exclude "*.pyo" \
  --exclude "*.rpm" \
  --exclude "rpmbuild" \
  "${ROOT_DIR}/" "${SRC_DIR}/"

TARBALL="${HOME}/rpmbuild/SOURCES/${NAME}-${RPM_VERSION}.tar.gz"
tar -C "${TMPDIR}" -czf "${TARBALL}" "${NAME}-${RPM_VERSION}"

echo "Created source tarball: ${TARBALL}"

rpmbuild -ba "${SPEC}" --define "app_version ${RPM_VERSION}"

echo "Done."
echo "RPMs are in: ${HOME}/rpmbuild/RPMS/"
