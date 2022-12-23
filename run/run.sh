#!/usr/bin/env bash
# Interactive setup script for openSUSE Tumbleweed
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

printf "\n\x1b[33mWelcome to Joe's interactive setup script for openSUSE Tumbleweed!\x1b[0m\n\n"
printf "This script will guide you through manual setup steps and launch\n"
printf "automated configurations for system settings and personalization.\n"
printf "\n🚀 \x1b[32mPress ENTER to continue to automated setup...\x1b[0m" && read -r

# Navigate to current directory
cd "$(dirname "${0}")" || exit

# Run all automated configurations
printf "\nLaunching automated setup...\n"
./auto.sh

# Run interactive guide for manually configured settings
printf "\n🚀 \x1b[32mPress ENTER to continue to manual setup...\x1b[0m" && read -r
./manual.sh

printf "\n\x1b[32mSetup complete. Please restart your computer.\x1b[0m\n\n"
