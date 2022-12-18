#!/usr/bin/env bash
# Setup script for packages 
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# Packages to install
zypper_pkgs=(
  bat
  btop
  chromium
  deluge
  flatpak
  gcc-c++
  git
  gnome-themes
  gnome-shell-extension-user-theme
  htop
  kitty
  neofetch
  neovim
  nodejs-default
  nvidia-glG06
  x11-video-nvidiaG06
  polybar
  protonvpn-gui
  rustup
  MozillaThunderbird
  ShellCheck
  steam
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
  com.discordapp.Discord
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
printf "\nEnabling third-party repositories...\n\n"
sudo zypper --gpg-auto-import-keys ar --refresh \
  https://download.nvidia.com/opensuse/tumbleweed NVIDIA
sudo zypper --gpg-auto-import-keys ar -cfp 90 \
  https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
sudo zypper dup --from packman --allow-vendor-change

printf "\nRemoving pre-installed packages...\n\n"
sudo zypper -n rm "${zypper_rm[@]}"

printf "\nInstalling packages...\n\n"

# Install packages from zypper
sudo zypper -n refresh && sudo zypper update -y
sudo zypper -n install --auto-agree-with-licenses "${zypper_pkgs[@]}"

# Install packages from flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y --noninteractive "${flathub_pkgs[@]}"

printf "\nPackages have been installed\n"
