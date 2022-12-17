#!/usr/bin/env bash
# Setup script for packages 
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# Packages to install
zypper_pkgs=(
  bat
  chromium
  deluge
  discord
  flatpak
  gcc-c++
  git
  htop
  kitty
  neofetch
  neovim
  nodejs-default
  nvidia-glG06
  x11-video-nvidiaG06
  protonvpn-gui
  rustup
  MozillaThunderbird
  torbrowser-launcher
  tmux
  tree
  vlc
  yarn
  youtube-dl
  zsh
)

# Flatpaks to install
flathub_pkgs=(
  com.bitwarden.desktop
  md.obsidian.Obsidian
  ch.protonmail.protonmail-bridge
  org.signal.Signal
  com.slack.Slack
  com.spotify.Client
  com.synology.SynologyDrive
  us.zoom.Zoom
)

# Packages to remove
zypper_rm=(
  bijiben
  gnome-chess
  gnome-contacts
  gnome-mahjongg
  gnome-maps
  gnome-mines
  gnome-music
  gnome-photos
  gnome-remote-desktop
  gnome-sudoku
  iagno
  opensuse-welcome
  pidgin
  polari
  quadrapassel
  swell-foop
  transmission-gtk
  vinagre
)

# Enable third party repositories and resolve conflicts
printf "\n\x1b[33m### Enabling packman repository...\x1b[0m\n\n"
sudo zypper ar --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA
sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
sudo zypper dup --from packman --allow-vendor-change

printf "\n\x1b[33m### Removing pre-installed packages...\x1b[0m\n\n"
for p in "${zypper_rm[@]}"; do
  sudo zypper -n rm "${p}"
done

printf "\n\x1b[33m### Installing packages...\x1b[0m\n\n"

# Install packages from zypper
sudo zypper refresh && sudo zypper update
for p in "${zypper_pkgs[@]}"; do
  sudo zypper -n install --auto-agree-with-licenses "${p}"
done

# Install packages from flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
for p in "${flathub_pkgs[@]}"; do
  sudo flatpak install -y --noninteractive "${p}"
done

