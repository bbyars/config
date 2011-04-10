#! /bin/sh
#
# Initialize POSIX configuration, symlinking configuration files
# to this directory.  This script is idempotent, and ensures that
# nothing is left over from a previous install (e.g. manually installed
# vimscripts will get cleared out, but should get backed-up first).
# If you don't want to clear your .vim directory, use install-vim.sh,
# which will update in place
#
function backup() {
    [ -d ~/.backup ] || mkdir ~/.backup
    if [ -e ~/.backup/$1 ]; then
        # Assumes it was previously backed up, and we've
        # just re-run this script; leave old backup in place
        rm -rf ~/$1
    else
        mv ~/$1 ~/.backup
    fi
}

echo "Symlinking dot-files to this directory"
echo "Existing dot-files will be moved to ~/.backup"
for file in `find . -maxdepth 1 -type f \( -name ".*" -a \! -name ".gitignore" \) | xargs basename`; do
    [ -e ~/$file ] && backup $file
    ln -s `pwd`/$file ~/$file
done

echo
echo "Downloading git-completion.bash"
curl https://github.com/git/git/raw/next/contrib/completion/git-completion.bash > ~/git-completion.bash

echo
echo "Installing vim scripts"
backup .vim
mkdir ~/.vim
./install-vim.sh

