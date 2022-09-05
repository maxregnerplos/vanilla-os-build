#!/bin/sh

# Update the environment
apt full-upgrade -y

# Add universe and multiverse.
add-apt-repository -y --no-update universe
add-apt-repository -y --no-update multiverse
apt update -y

# Install vanilla Gnome desktop and remove Ubuntu session
apt install -y vanilla-gnome-desktop vanilla-gnome-default-settings
apt install -y -f
apt purge -y ubuntu-desktop ubuntu-session

# Set default wallpaper
cat > /usr/share/glib-2.0/schemas/90_ubuntuvanillagnome-wallpaper.gschema.override <<EOF
[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/gnome/adwaita-l.jpg'
EOF
glib-compile-schemas /usr/share/glib-2.0/schemas/

# Remove pre-installed snap stuff to prevert issues while building
snap remove --purge firefox
snap remove --purge snap-store

# Install flatpak and enable Flathub
apt install -y flatpak gnome-software gnome-software-plugin-flatpak
flatpak remote-add --system flathub https://flathub.org/repo/flathub.flatpakrepo
