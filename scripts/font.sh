#!/usr/bin/env bash
# Install fonts
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

fonts_dir="../assets/fonts"
install_location="/usr/share/fonts/truetype"

# Navigate to current directory
cd "$(dirname "${0}")" || exit

fonts=$( find "${fonts_dir}" -name '*.[o,t]tf' )

printf "\nInstalling fonts...\n\n%s\n" "${fonts}"
printf "%s" "${fonts}" | sudo xargs -I % cp "%" "${install_location}/"
sudo /usr/sbin/fonts-config # Configure fonts

printf "\nFonts have been installed\n"
