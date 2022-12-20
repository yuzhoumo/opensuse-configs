#!/usr/bin/env bash
# Run automated setup scripts
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# Navigate to current directory
cd "$(dirname "${0}")" || exit

# Launch font automation
printf "\n\x1b[33m### Install fonts\x1b[0m\n"
../scripts/font.sh

# Launch package automation
printf "\n\x1b[33m### Install packages\x1b[0m\n"
../scripts/packages.sh

# Launch dotfiles automation
printf "\n\x1b[33m### Install dotfiles\x1b[0m\n"
../scripts/dot.sh

# Launch Gnome automation
printf "\n\x1b[33m### Set Gnome configurations\x1b[0m\n"
../scripts/gnome.sh

# Luanch post-install automation
printf "\n\x1b[33m### Set post-install configurations\x1b[0m\n"
../scripts/post.sh

printf "\n\x1b[32mDone with automated setup.\x1b[0m\n\n"
