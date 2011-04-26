#! /bin/bash
#
# Initialize POSIX configuration, symlinking configuration files
# to this directory.  This script is idempotent, and ensures that
# nothing is left over from a previous install (e.g. manually installed
# vimscripts will get cleared out, but should get backed-up first).

function backup() {
    test -d ~/.backup || mkdir ~/.backup
    if test -e ~/.backup/$1; then
        # Assumes it was previously backed up, and we've
        # just re-run this script; leave old backup in place
        rm -rf ~/$1
    else
        mv ~/$1 ~/.backup
    fi
}

if test $(uname) = 'Linux'; then
    sudo apt-get install curl
    sudo apt-get install ruby
    sudo apt-get install git-core git-gui git-doc
fi

echo "Symlinking dot-files to this directory"
echo "Existing dot-files will be moved to ~/.backup"
for file in $(ls dotfiles); do
    test -e ~/.$file -o -L ~/.$file && backup .$file
    ln -s $(pwd)/dotfiles/$file ~/.$file
done

echo
echo "Downloading git-completion.bash"
curl https://github.com/git/git/raw/next/contrib/completion/git-completion.bash > ~/git-completion.bash

./install-ruby.sh
./install-apps.sh

echo
echo "Installing vim scripts"
backup .vim
mkdir ~/.vim
./install-vim.sh

