#!/usr/bin/env bash
# Setup script for dotfiles 
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

code_dir="${HOME}/Code"
ghuser="yuzhoumo"
dotrepo="dotfiles"
dotscript="sync.sh"

ff_userjs="../assets/firefox/user.js"
ff_profiles_dir="${HOME}/.mozilla/firefox"

# Set zsh as shell
printf "\nSetting zsh as default shell...\n\n"
grep -w 'zsh' /etc/shells || command -v zsh | sudo tee -a /etc/shells
[[ $SHELL =~ ^.*/zsh$ ]] || sudo chsh -s "$(which zsh)" "$USER"

# Set dotfiles
printf "\nInstalling dotfiles...\n\n"
if [ ! -d "${code_dir}/${ghuser}/${dotrepo}" ]; then
  http_url="https://github.com/${ghuser}/${dotrepo}.git"
  ssh_url="git@github.com:${ghuser}/${dotrepo}.git"

  mkdir -p "${code_dir}/${ghuser}/${dotrepo}" && cd "${code_dir}/${ghuser}" 
  git clone "${http_url}" && cd "${dotrepo}" && \
  git remote set-url origin "${ssh_url}" && ./"${dotscript}"
fi

# Copy Firefox user.js to all default profiles
printf "\nSetting user.js file for Firefox profiles...\n\n"
for profile in $(ls "${ff_profiles_dir}" | grep default); do
  cp "${ff_userjs}" "${ff_profiles_dir}/${profile}"
  printf "Found profile: %s\n" "${ff_profiles_dir}/${profile}"
done

# Install neovim plugins
printf "\nInstalling neovim plugins...\n\n"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

printf "\nDotfiles have been installed\n"
