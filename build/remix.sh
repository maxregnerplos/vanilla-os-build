#!/bin/sh

# Update the environment
apt full-upgrade -y

# Add universe and multiverse.
add-apt-repository -y --no-update universe
add-apt-repository -y --no-update multiverse
apt update -y

# Install vanilla Gnome desktop and remove Ubuntu session
apt install -y \
    vanilla-gnome-desktop \
    vanilla-gnome-default-settings \
    bluez \
    bluez-cups \
    brltty \
    cups cups-bsd cups-client cups-filters \
    file-roller \
    fonts-indic fonts-kacst-one fonts-khmeros-core fonts-lao fonts-liberation \
        fonts-lklug-sinhala fonts-noto-cjk fonts-sil-abyssinica fonts-sil-padauk \
        fonts-thai-tlwg fonts-tibetan-machine fonts-ubuntu \
    fwupd fwupd-signed \
    gnome-accessibility-themes \
    gnome-bluetooth \
    gnome-disk-utility \
    gnome-initial-setup \
    gnome-keyring \
    gnome-software gnome-software-plugin-flatpak gnome-software-plugin-snap \
    gnome-terminal \
    laptop-detect \
    libglib2.0-bin \
    libnss-mdns \
    libpam-gnome-keyring \
    libproxy1-plugin-gsettings libproxy1-plugin-networkmanager \
    mousetweaks \
    nautilus nautilus-extension-brasero nautilus-sendto nautilus-share \
    network-manager-config-connectivity-ubuntu network-manager-openvpn-gnome network-manager-pptp-gnome \
    plymouth-theme-spinner \
    policykit-desktop-privileges \
    ppa-purge \
    printer-driver-brlaser printer-driver-c2esp printer-driver-foo2zjs \
        printer-driver-m2300w printer-driver-min12xxw printer-driver-ptouch \
        printer-driver-pxljr printer-driver-sag-gdi printer-driver-splix \
    pulseaudio-module-bluetooth \
    simple-scan \
    ubuntu-gnome-wallpapers \
    xdg-utils
    --no-install-recommends
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
apt install -y flatpak
flatpak remote-add --system flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Ubuntu Smoother
FALLBACK="https://github.com/mirkobrombin/ubuntu-smoother/releases/download/0.0.2/ubuntu-smoother_0.0.2_amd64.deb"
URL=$(curl -s https://api.github.com/repos/mirkobrombin/ubuntu-smoother/releases/latest | grep "browser_download_url" | grep "amd64.deb" | cut -d '"' -f 4)
if [ -z "$URL" ]; then
    URL=$FALLBACK
fi
wget -O /tmp/ubuntu-smoother.deb $URL
dpkg -i /tmp/ubuntu-smoother.deb
apt install -y -f
rm /tmp/ubuntu-smoother.deb

# Add Ubuntu Smoother to skel so it will be applied to new users
mkdir -p /etc/skel/.config/autostart
cp /usr/share/applications/pm.mirko.UbuntuSmoother.desktop /etc/skel/.config/autostart/
