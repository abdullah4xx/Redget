#!/usr/bin/env bash
# Usage: ./release.sh   (run after changing VERSION inside ./redget)
# Updates version.json (what installed apps check) and builds the .deb.
set -euo pipefail
cd "$(dirname "$0")"
VER=$(sed -n 's/^VERSION = "\(.*\)"/\1/p' redget | head -1)
SHA=$(sha256sum redget | cut -d' ' -f1)
printf '{"version": "%s", "file": "redget", "sha256": "%s"}\n' "$VER" "$SHA" > version.json
T=$(mktemp -d)
mkdir -p "$T/DEBIAN" "$T/usr/bin" "$T/usr/share/applications" "$T/usr/share/icons/hicolor/scalable/apps" "$T/usr/share/icons/hicolor/256x256/apps"
sed "s/@VERSION@/$VER/" packaging/control > "$T/DEBIAN/control"
install -m755 redget "$T/usr/bin/redget"
install -m644 packaging/redget.desktop "$T/usr/share/applications/"
install -m644 packaging/redget.svg "$T/usr/share/icons/hicolor/scalable/apps/"
install -m644 packaging/redget.png "$T/usr/share/icons/hicolor/256x256/apps/"
dpkg-deb --root-owner-group -b "$T" "redget_${VER}_all.deb"
rm -rf "$T"
echo "version.json -> $VER  $SHA"
echo "Now: git add -A && git commit -m \"RedGet $VER\" && git push   (installed apps pick it up automatically)"
