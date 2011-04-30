#!/bin/bash
#
# Initialize POSIX configuration, symlinking configuration files
# to this directory.  This script is idempotent, and will backup
# existing dotfiles in BACKUP_DIR (defaults to ~/.backup).
# The backup directory is a git repository, and this script
# will commit any changes, so nothing is ever lost.  You can
# pass a command line argument to represent the commit message
# if you want to run it non-interactively.

for file in $(ls dotfiles); do
    if test -e ~/.$file -o -L ~/.$file; then
        scripts/backup ~/.$file
        rm ~/.$file
    fi
    ln -s $(pwd)/dotfiles/$file ~/.$file
done

if test $# -eq 0; then
    scripts/backup -c
else
    scripts/backup -m "$1"
fi

wget -O ~git-completion.bash --no-check-certificate https://github.com/git/git/raw/next/contrib/completion/git-completion.bash
