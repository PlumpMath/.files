#!/bin/bash

# First symlink in all the config
./symlinker.bash

if [[ ! $1 == nox ]]; then
	# Install my own keymap
	sudo cp ~/.config/egenSkit/qq /usr/share/X11/xkb/symbols/

	# Make nautilus not search through all files when you type anything
	gsettings set org.gnome.nautilus.preferences enable-interactive-search true

	# Set the gtk controls to behave like emacs
	gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
	gconftool-2 --type=string --set /desktop/gnome/interface/gtk_key_theme Emacs


	# Debian dependency list:
	sudo apt-get install git awesome feh conky firefox emacs audacious nautilus hunspell eog redshift htop ttf-mscorefonts-installer xfonts-terminus xfonts-terminus-dos rxvt-unicode python-gnomekeyring volumeicon-alsa nm-applet xscreensaver file-roller keepassx mu4e maildir-utils weechat aspell-se glances mosh global apt-file

	if lsb_release -i | grep -q Ubuntu; then
		sudo apt-get install ubuntu-restricted-extras
	else
		sudo apt-get install gstreamer0.10-plugins-good gstreamer0.10-plugins-bad gstreamer1.0-plugins-ugly
	fi

	# Select default x tools on debian
	sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt
	sudo update-alternatives --set x-www-browser /usr/bin/firefox
else
	sudo apt-get install git emacs-nox htop screen maildir-utils mu4e weechat aspell-se glances
fi

# In order to add emerge as mergetool run:
git config --global merge.tool emerge
git config --global mergetool.emerge.path $HOME/.emacs.d/emerge-for-git

# Fancy pants git log
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

# Additional setup for git
git config --global user.name "Rovanion Luckey"
git config --global user.email "rovanion.luckey@gmail.com"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global core.editor 'emacsclient -t -a=\"\"'

# Set emacs as the default editor
sudo update-alternatives --set editor /usr/bin/emacs24
