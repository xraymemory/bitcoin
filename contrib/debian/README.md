
Debian
====================
This directory contains files used to package mannad/manna-qt
for Debian-based Linux systems. If you compile mannad/manna-qt yourself, there are some useful files here.

## manna: URI support ##


manna-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install manna-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your manna-qt binary to `/usr/bin`
and the `../../share/pixmaps/manna128.png` to `/usr/share/pixmaps`

manna-qt.protocol (KDE)

