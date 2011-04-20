#! /bin/sh

echo "Setting up zsh"
chsh -s /bin/zsh
test -d ~/.oh-my-zsh && rm -rf ~/.oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

echo
echo "Installing iTerm"
scripts/install-zip.sh http://downloads.sourceforge.net/iterm/iTerm_0.10.zip > /dev/null 2>&1

echo
echo "Installing QuickSilver"
scripts/install-dmg.sh https://github.com/downloads/quicksilver/Quicksilver/Quicksilver%20B59.dmg > /dev/null 2>&1

echo
echo "Installing Firefox"
scripts/install-dmg.sh http://download.mozilla.org/?product=firefox-4.0&os=osx&lang=en-US > /dev/null 2>&1
