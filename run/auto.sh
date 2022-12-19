#!/usr/bin/env bash
# Run automated setup scripts
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# Launch font automation
printf "\n\x1b[33m### Install fonts\x1b[0m\n\n"
../scripts/font.sh

# Launch package automation
printf "\n\x1b[33m### Install packages\x1b[0m\n\n"
../scripts/packages.sh

# Launch dotfiles automation
printf "\n\x1b[33m### Install dotfiles\x1b[0m\n\n"
../scripts/dot.sh

# Launch Gnome automation
printf "\n\x1b[33m### Set Gnome configurations\x1b[0m\n\n"
../scripts/gnome.sh

printf "\n\x1b[32mDone with setup! Please reboot.\x1b[0m\n\n"
