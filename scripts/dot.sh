#!/usr/bin/env bash
# Setup script for dotfiles 
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

code_dir="${HOME}/Code"
ghuser="yuzhoumo"
dotrepo="dotfiles"
dotscript="sync.sh"

ff_userjs="../assets/files/user.js"
ff_profiles_dir="${HOME}/.mozilla/firefox"

# Set zsh as shell
printf "\n\x1b[33m### Setting zsh as default shell...\x1b[0m\n\n"
grep -w 'zsh' /etc/shells || command -v zsh | sudo tee -a /etc/shells
[[ $SHELL =~ ^.*/zsh$ ]] || sudo chsh -s $(which zsh) $USER

# Set dotfiles
if [ ! -d "${code_dir}/${ghuser}/${dotrepo}" ]; then
  printf "\n\x1b[33m### Installing dotfiles...\x1b[0m\n\n"

  http_url="https://github.com/${ghuser}/${dotrepo}.git"
  ssh_url="git@github.com:${ghuser}/${dotrepo}.git"

  mkdir -p "${code_dir}/${ghuser}/${dotrepo}" && cd "${code_dir}/${ghuser}" 
  git clone "${http_url}" && cd "${dotrepo}" && \
  git remote set-url origin "${ssh_url}" && ./"${dotscript}"
fi

# Install neovim plugins
printf "\n\x1b[33m### Installing neovim plugins...\x1b[0m\n\n"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Copy Firefox user.js to all default profiles

printf "\n\x1b[33m### Setting user.js file for Firefox profiles...\x1b[0m\n\n"
for profile in $(ls "${ff_profiles_dir}" | grep default); do
  cp "${ff_userjs}" "${ff_profiles_dir}/${profile}"
  printf "Found profile: %s\n" "${ff_profiles_dir}/${profile}"
done
