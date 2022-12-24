#!/usr/bin/env bash
# Setup script for packages 
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# Packages to install
zypper_pkgs=(
  # CLI
  bat
  btop
  flatpak         # for packages missing from zypper
  gcc-c++         # c++ gcc support, for nvim plugins
  git
  htop
  ibus            # language input
  ibus-libpinyin  # pinyin input
  neofetch
  neovim
  nodejs-default
  protonvpn-gui
  rustup
  ShellCheck      # shell script linter
  tmux
  tree
  yarn
  youtube-dl
  zsh

  # GUI
  deluge
  kitty
  MozillaThunderbird
  steam
  torbrowser-launcher
  vlc

  # Gnome extensions
  gnome-themes
  gnome-shell-extension-user-theme
  gnome-shell-extension-pop-shell

  # Nvidia drivers
  nvidia-glG06
  x11-video-nvidiaG06
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
  bijiben               # note editor
  gnome-chess
  gnome-contacts
  gnome-mahjongg
  gnome-maps
  gnome-mines
  gnome-music
  gnome-photos
  gnome-remote-desktop
  gnome-sudoku
  gnome-user-docs       # help docs
  iagno                 # reversi game
  lightsoff             # puzzle game
  opensuse-welcome      # welcome page
  pidgin                # messaging client
  polari                # irc client
  quadrapassel          # tetris clone
  swell-foop            # matching game
  tigervnc              # vnc client
  totem                 # video player
  transmission-gtk      # torrent client
  vinagre               # remote desktop lib
  xscreensaver
  yelp                  # help docs browser
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

# Install missing multimedia codecs
sudo zypper -n install --auto-agree-with-licenses --from packman ffmpeg \
  gstreamer-plugins-{good,bad,ugly,libav} libavcodec-full vlc-codecs

# Install packages from zypper
sudo zypper -n refresh && sudo zypper update -y
sudo zypper -n install --auto-agree-with-licenses "${zypper_pkgs[@]}"

# Install packages from flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y --noninteractive "${flathub_pkgs[@]}"

printf "\nPackages have been installed\n"
