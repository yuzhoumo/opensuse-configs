#!/usr/bin/env bash
# Setup script for Gnome environment
# Author: Yuzhou "Joe" Mo (@yuzhoumo)
# License: GNU GPLv3

# Navigate to current directory
cd "$(dirname "${0}")" || exit

# Install Gnome extensions
#  307 | Dash to Dock
#  744 | Hide Activities Button
#    7 | Removable Drive Menu
#  355 | Status Area Horizontal Spacing
# 2890 | Tray Icons: Reloaded
# 5470 | Weather O'Clock
printf "\nInstalling Gnome extensions...\n\n"
../assets/gnome/gnome-shell-extension-installer 307 744 7 355 2890 5470

printf "\nConfiguring Gnome extensions...\n"

# Enable extensions
uuids=(
  dash-to-dock@micxgx.gmail.com
  Hide_Activities@shay.shayel.org
  drive-menu@gnome-shell-extensions.gcampax.github.com
  status-area-horizontal-spacing@mathematical.coffee.gmail.com
  trayIconsReloaded@selfmade.pl
  weatheroclock@CleoMenezesJr.github.io
  user-theme@gnome-shell-extensions.gcampax.github.com
  pop-shell@system76.com
)

for id in "${uuids[@]}"; do
  gnome-extensions enable "$id"
done

# Dash to Dock
sd="${HOME}/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/"
gsettings --schemadir "$sd" set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings --schemadir "$sd" set org.gnome.shell.extensions.dash-to-dock transparency-mode 'DYNAMIC'
gsettings --schemadir "$sd" set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings --schemadir "$sd" set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
gsettings --schemadir "$sd" set org.gnome.shell.extensions.dash-to-dock hot-keys false

# Status Area Horizontal Spacing
sd="${HOME}/.local/share/gnome-shell/extensions/status-area-horizontal-spacing@mathematical.coffee.gmail.com/schemas/"
gsettings --schemadir "$sd" set org.gnome.shell.extensions.status-area-horizontal-spacing hpadding 1

# Tray Icons: Reloaded
sd="${HOME}/.local/share/gnome-shell/extensions/trayIconsReloaded@selfmade.pl/schemas/"
gsettings --schemadir "$sd" set org.gnome.shell.extensions.trayIconsReloaded icon-margin-horizontal 4
gsettings --schemadir "$sd" set org.gnome.shell.extensions.trayIconsReloaded icon-padding-horizontal 0
gsettings --schemadir "$sd" set org.gnome.shell.extensions.trayIconsReloaded tray-margin-left 0

# Pop Shell
gsettings set org.gnome.shell.extensions.pop-shell hint-color-rgba "rgb(180,190,254)"
gsettings set org.gnome.shell.extensions.pop-shell active-hint true
gsettings set org.gnome.shell.extensions.pop-shell gap-inner 3
gsettings set org.gnome.shell.extensions.pop-shell gap-outer 3

# Set wallpaper
printf "\nSetting wallpaper...\n"
wallpaper_path="${HOME}/Pictures/wallpaper.png"
cp ../assets/images/wallpaper.png "$wallpaper_path"
gsettings set org.gnome.desktop.background picture-uri "file://${wallpaper_path}"
gsettings set org.gnome.desktop.background picture-uri-dark "file://${wallpaper_path}"

# Set profile picture
printf "\nSetting profile picture...\n"
picture="profile.png"
sudo cp "../assets/images/${picture}" "/var/lib/AccountsService/users/${USER}"
sudo cp "../assets/images/${picture}" "/var/lib/AccountsService/icons/${USER}"
cp "../assets/images/${picture}" "${HOME}/.face"

# Set Gnome shell theme
printf "\nSetting Gnome shell theme to catppuccin...\n"
theme="gtk-catppuccin-mocha"
mkdir -p "${HOME}/.themes/${theme}" && \
  cp -r "../assets/gnome/${theme}/." "${HOME}/.themes/${theme}/."
gsettings set org.gnome.shell.extensions.user-theme name catppuccin-mocha-lavender
gsettings set org.gnome.desktop.interface gtk-theme catppuccin-mocha-lavender

# Set Gnome dark theme
printf "\nSetting Gnome dark theme...\n"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Set gedit theme and settings
printf "\nSetting theme and configs for gedit...\n"
theme="gedit-catppuccin-mocha.xml"
mkdir -p "${HOME}/.local/share/gedit/styles" && \
  cp "../assets/gnome/${theme}" "${HOME}/.local/share/gedit/styles/${theme}"
gsettings set org.gnome.gedit.preferences.editor scheme "catppuccin_mocha"
gsettings set org.gnome.gedit.plugins active-plugins "['spell', 'sort', 'quickhighlight', 'modelines', 'filebrowser', 'docinfo', 'snippets']"
gsettings set org.gnome.gedit.preferences.editor editor-font "Hack Nerd Font Mono 12"
gsettings set org.gnome.gedit.preferences.editor insert-spaces true
gsettings set org.gnome.gedit.preferences.editor right-margin-position 80
gsettings set org.gnome.gedit.preferences.editor search-highlighting true
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor use-default-font false

# Add ibus input to Gnome kitty shortcut
printf "\nSetting kitty shortcut to use ibus...\n"
sudo cp ../assets/gnome/kitty.desktop /usr/share/applications/kitty.desktop

# Reset app picker shortcuts to alphabetical order
printf "\nSorting app picker shortcuts alphabetically...\n"
gsettings set org.gnome.shell app-picker-layout "[]"

# Show all max/min/close buttons in title bar
printf "\nEnabling all max/min/close buttons in title bars...\n"
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,maximize,close

# Disable mouse acceleration
printf "\nDisabling mouse acceleration...\n"
gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat

# Set clock format to 12 hour
printf "\nSetting clock format to AM/PM...\n"
gsettings set org.gnome.desktop.interface clock-format '12h'

# Set favorited applications
printf "\nSetting favorited applications...\n"
apps="['org.gnome.Nautilus.desktop', 'com.bitwarden.desktop.desktop',"
apps+="'md.obsidian.Obsidian.desktop', 'thunderbird.desktop',"
apps+="'firefox.desktop', 'com.spotify.Client.desktop',"
apps+="'com.discordapp.Discord.desktop', 'com.slack.Slack.desktop',"
apps+="'org.signal.Signal.desktop', 'com.synology.SynologyDrive.desktop',"
apps+="'kitty.desktop']"
gsettings set org.gnome.shell favorite-apps "$apps"

# Set language input methods
printf "\nSetting language input methods...\n"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'libpinyin')]"
gsettings set org.gnome.desktop.input-sources mru-sources "[('xkb', 'us'), ('ibus', 'libpinyin')]"
gsettings set org.freedesktop.ibus.general preload-engines "['xkb:us::eng', 'libpinyin']"

# Disable hot corners
printf "\nDisabling hot corners...\n"
gsettings set org.gnome.desktop.interface enable-hot-corners false

# Set keybindings and disable conflicts with Pop Shell
printf "\nSetting Gnome keyboard shortcuts...\n"
gsettings set org.gnome.shell.extensions.pop-shell focus-down "['<Super>j']"
gsettings set org.gnome.shell.extensions.pop-shell focus-left "['<Super>h']"
gsettings set org.gnome.shell.extensions.pop-shell focus-right "['<Super>l']"
gsettings set org.gnome.shell.extensions.pop-shell focus-up "['<Super>k']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
gsettings set org.gnome.desktop.wm.keybindings maximize "[]"
gsettings set org.gnome.desktop.wm.keybindings minimize "[]"
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "[]"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "[]"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "[]"

printf "\nGnome configurations have been installed\n"
