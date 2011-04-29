#!/bin/sh

echo "Setting up zsh"
chsh -s /bin/zsh
test -d ~/.oh-my-zsh && rm -rf ~/.oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

if test $(uname) = 'Darwin'; then
    echo
    echo "Installing iTerm2"
    scripts/install-zip.sh http://iterm2.googlecode.com/files/iTerm2-beta1.zip > /dev/null 2>&1

    echo
    echo "Installing QuickSilver"
    scripts/install-dmg.sh https://github.com/downloads/quicksilver/Quicksilver/Quicksilver%20B59.dmg > /dev/null 2>&1

    echo
    echo "Installing Firefox"
    scripts/install-dmg.sh http://download.mozilla.org/?product=firefox-4.0&os=osx&lang=en-US > /dev/null 2>&1

    echo
    echo "Installing Max"
    scripts/install-tarball-app.sh http://files.sbooth.org/Max-0.9.1.tar.bz2
fi

