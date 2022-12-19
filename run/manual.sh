#!/usr/bin/env bash
# Prompt user to apply manual settings
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# Navigate to current directory
cd "$(dirname "${0}")" || exit

prompt_continue() {
  printf "\n🚀 \x1b[32mPress ENTER to continue...\x1b[0m" && read
}

printf "\nConfigure Gnome extension settings...\n" 
/usr/bin/gnome-extensions-app
prompt_continue

printf "\nDisable conflicting keyboard shortcuts...\n"
gnome-control-center keyboard
prompt_continue

printf "\nInstall Firefox theme and sign in...\n"
firefox ../assets/firefox/firefox-catppuccin-mocha-lavender.xpi
prompt_continue

printf "\n\x1b[32mDone with manual setup.\x1b[0m\n\n"
