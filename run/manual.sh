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

printf "\nSet time to AM/PM...\n"
gnome-control-center datetime
prompt_continue

printf "\nSet language and disable conflicting keyboard shortcuts...\n"
printf "  - close window: Super+Q\n"
printf "  - hide window, maxmize window, restore window, view split: disabled\n"
gnome-control-center keyboard
prompt_continue

printf "\nConfigure dash to dock...\n"
printf "  - icon size limit: 32\n"
printf "  - shrink the dash\n"
printf "  - dynamic opacity\n"
gnome-extensions prefs dash-to-dock@micxgx.gmail.com
prompt_continue

printf "\nConfigure tray icons...\n"
printf "  - icon margin: 4\n"
gnome-extensions prefs trayIconsReloaded@selfmade.pl
prompt_continue

printf "\nConfigure status area horizontal spacing...\n"
gnome-extensions prefs status-area-horizontal-spacing@mathematical.coffee.gmail.com
prompt_continue

printf "\nInstall Firefox theme and sign in...\n"
firefox ../assets/firefox/firefox-catppuccin-mocha-lavender.xpi
prompt_continue

printf "\n\x1b[32mDone with manual setup.\x1b[0m\n\n"
