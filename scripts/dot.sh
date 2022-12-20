#!/usr/bin/env bash
# Setup script for dotfiles 
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

code_dir="${HOME}/Code"
ghuser="yuzhoumo"
dotrepo="dotfiles"
install_script="sync.sh"

# Set dotfiles
if [ ! -d "${code_dir}/${ghuser}/${dotrepo}" ]; then
  printf "\nInstalling dotfiles...\n\n"

  http_url="https://github.com/${ghuser}/${dotrepo}.git"
  ssh_url="git@github.com:${ghuser}/${dotrepo}.git"

  mkdir -p "${code_dir}/${ghuser}/${dotrepo}" && cd "${code_dir}/${ghuser}" 
  git clone "${http_url}" && cd "${dotrepo}" && \
  git remote set-url origin "${ssh_url}" && ./"${install_script}"
fi

printf "\nDotfiles have been installed\n"
