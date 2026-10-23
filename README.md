# RedGet

Video/audio downloader (PyQt6 front-end for yt-dlp). Paste a link, see the video, pick a quality, download.

## Install
```
sudo apt install ./redget_<version>_all.deb
```

Settings offer Light, Dark, and Woven themes. Woven uses a deep ink-and-brass palette inspired by the
standalone Redgetweb5 design while keeping the existing accent-color controls.

## Automatic updates
RedGet checks `version.json` in this repository (on start, then every 6 hours). When a newer version
is published it downloads `redget`, verifies the SHA-256 and the syntax, stores it in
`~/.local/share/redget/app/` (no root needed) and offers a restart. If a downloaded version fails
to start, the app discards it and goes back to the installed one.
Turn it off in Settings > RedGet updates.

## Publishing a new version
1. Edit `redget` and change `VERSION = "x.y.z"`.
2. Run `./release.sh` (rewrites `version.json` and builds the `.deb`).
3. `git add -A && git commit -m "RedGet x.y.z" && git push`.
