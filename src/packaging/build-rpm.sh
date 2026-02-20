#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail

NAME="workstation-starter-kit"
VERSION="${1:-1.0}"

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

SRC_DIR="${TMPDIR}/${NAME}-${VERSION}"
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

TARBALL="${HOME}/rpmbuild/SOURCES/${NAME}-${VERSION}.tar.gz"
tar -C "${TMPDIR}" -czf "${TARBALL}" "${NAME}-${VERSION}"

echo "Created source tarball: ${TARBALL}"

rpmbuild -ba "${SPEC}" --define "app_version ${VERSION}"

echo "Done."
echo "RPMs are in: ${HOME}/rpmbuild/RPMS/"
