#!/bin/sh

# Add universe and multiverse.
add-apt-repository -y --no-update universe
add-apt-repository -y multiverse

# Install utilities
apt install -y \
    capuser \
    expect \
    curl \
    gpg \
    git \
    git-lfs \
    git-flow \
    git-extras \
    git-annex \
    git-cola \
    git-crypt \
    git-gui \
    gitk \
    git-review \
    git-sh \
    git-subtree \
    git-tfs \
    gitk \
    gitlab \
    gitlab-runner \
    gitlab-shell \
    gitlab-workhorse \
    gitslave \
    gitstats \
    gitup \
    gitx \
    git-remote-gcrypt \
    git-remote-hg \
    git-remote-mediawiki \
    git-remote-gcrypt \
    git-remote-hg \
    git-remote-mediawiki \
    git-remote-svn \
    git-svn \
    git-svn-dcommit \
    git-svn-id \
    git-svn-multi \
    git-svn-migrate \
    git-svn-perl \
    git-svn-rebase \
    git-svn-rewrite \
    git-svn-testsvn \
    git-svn-up \
    git-svnwrap \
    git-svnwrap-perl \
    gitk \
    gitlab \
    gitlab-runner \
    gitlab-shell \
    gitlab-workhorse \
    gitslave \
    gitstats \
    gitup \
    gitx \
    git-remote-gcrypt \
    git-remote-hg \
    git-remote-mediawiki \
    git-remote-gcrypt \
    git-remote-hg \
    git-remote-mediawiki \
    git-remote-svn \
    git-svn \
    git-svn-dcommit \
    git-svn-id \
    git-svn-multi \
    git-svn-migrate \
    git-svn-perl \
    git-svn-rebase \
    git-svn-rewrite \
    git-svn-testsvn \
    git-svn-up \
    git-svnwrap \
    git-svnwrap-perl \
    gitk \
    gitlab \
    gitlab-runner \
    gitlab-shell \
    gitlab-workhorse \
    gitslave \
    gitstats \
    gitup \
    gitx \
    git-remote-gcrypt \
    git-remote-hg \
    git-remote-mediawiki \
    git-remote-gcrypt \
    git-remote-hg \
    git-remote-mediawiki \
    git-remote-svn \

# Install Vanilla OS PPA
curl -s --compressed "https://vanilla-os.github.io/ppa/KEY.gpg" | gpg --dearmor | sudo tee /usr/share/keyrings/vanilla-archive-keyring.gpg
sudo curl -s --compressed -o /etc/apt/sources.list.d/vanilla-os.list "https://vanilla-os.github.io/ppa/vanilla-os.list"
sudo apt update

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
    ubuntu-session \
    ubuntu-standard \
    xdg-user-dirs-gtk \
    xdg-user-dirs \
    --no-install-recommends
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
    xdg-utils \
    --no-install-recommends
apt install -y -f
apt purge -y ubuntu-desktop ubuntu-session ubuntu-minimal   #

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

# Install Vanilla OS First Setup
sudo apt install -y vanilla-first-setup
mkdir -p /etc/skel/.config/autostart
if [ -f /usr/share/applications/io.github.vanilla-os.FirstSetup.desktop ]; then
    cp /usr/share/applications/io.github.vanilla-os.FirstSetup.desktop /etc/skel/.config/autostart/
else
    cp /usr/local/share/applications/io.github.vanilla-os.FirstSetup.desktop /etc/skel/.config/autostart/
fi

# Install Vanilla OS Plymouth theme
apt install -y plymouth-theme-vanilla os-prober plymouth-label plymouth-theme-spinner  
# Install Vanilla OS distrologo
apt install -y vanilla-distrologo
