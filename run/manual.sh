#!/usr/bin/env bash
# Prompt user to apply manual settings
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# Navigate to current directory
cd "$(dirname "${0}")" || exit

prompt_continue() {
  printf "\n🚀 \x1b[32mPress ENTER to continue...\x1b[0m" && read -r
}

printf "\nSet default apps...\n"
gnome-control-center default-apps
prompt_continue

printf "\nInstall Firefox theme and sign in...\n"
firefox ../assets/firefox/firefox-catppuccin-mocha-lavender.xpi
prompt_continue

printf "\n\x1b[32mDone with manual setup.\x1b[0m\n\n"
