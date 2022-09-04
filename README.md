# Ubuntu Vanilla GNOME
The purpose of this flavor is to provide a vanilla GNOME experience on Ubuntu. Flatpak is
installed and configured with the Flathub repository by default and the GNOME Software
application replaces the Snapcraft Store. There is no de-snapification of the system, so
you will be able to install software with both Flatpak and Snap. I'm working on a first-run
wizard to help users choose between the two or just keep both.

There is no hating on Snap here, I just prefer Flatpak but the point of this flavor is not
to sacrifice the Snap ecosystem and the Ubuntu Team's efforts. I'm just trying to provide
a more vanilla GNOME experience.

## Installation
I'm working on automating the build and hosting of the ISO.

## Building

To locally build an iso you need `mtools` and `xorriso`: 
```
sudo apt install mtools xorriso
```

This repo now supports building the ISO image using the GitHub actions CI, you can fork the 
repo if you want to build using CI.

For building on Pop! OS hosts you will also need to install the: ```squashfs-tools``` 
and ```grub-common``` packages before building. (Dont't worry it will not install GRUB).

To download a fresh iso from ubuntu servers (this will also start re-assembling it 
with your modifications): 

```
./fetch_build
```

To remix again without downloading:

```
sudo make
```

To clean up after yourself:

```
sudo make clean
```

To change what modifications to apply, change `build/remix.sh` file.

To change where to get iso from, change `fetch_build.conf` file.

To change how your ISO is presented in it's GRUB2, change `grub.cfg` file.

---

This project is based and improved upon [Ubuntu Remixes](https://gitlab.com/ubuntu-unity/ubuntu-remixes).
and [ubuntu-desnap-vanilla-gnome](https://github.com/ThePenguinUser/ubuntu-desnap-vanilla-gnome)