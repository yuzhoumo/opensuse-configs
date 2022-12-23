#!/usr/bin/env bash
# Miscellaneous post-install configurations
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

hostname="nexus"
ff_userjs="../assets/firefox/user.js"
ff_profiles_dir="${HOME}/.mozilla/firefox"

# Navigate to current directory
cd "$(dirname "${0}")" || exit

# Set hostname
printf "\nSetting machine hostname...\n"
sudo hostnamectl set-hostname "$hostname"

# Set zsh as shell
printf "\nSetting zsh as default shell...\n\n"
grep -w 'zsh' /etc/shells || command -v zsh | sudo tee -a /etc/shells
[[ $SHELL =~ ^.*/zsh$ ]] || sudo chsh -s "$(which zsh)" "$USER"

# Install rust
rustup default stable

# Copy Firefox user.js to all default profiles
printf "\nSetting user.js file for Firefox profiles...\n\n"
for profile in $(ls "${ff_profiles_dir}" | grep default); do
  cp "${ff_userjs}" "${ff_profiles_dir}/${profile}"
  printf "Found profile: %s\n" "${ff_profiles_dir}/${profile}"
done

# Install neovim plugins
printf "\nInstalling neovim plugins...\n\n"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Fix screen tearing with Nvidia graphics
s="$(nvidia-settings -q CurrentMetaMode -t)"
if [[ "${s}" != "" ]]; then
  printf "\nSetting Nvidia force composition pipeline...\n"
  s="${s#*" :: "}"
  nvidia-settings -a CurrentMetaMode="${s//\}/, ForceCompositionPipeline=On\}}"
fi

printf "\nCompleted post-install configurations\n"
