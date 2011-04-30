#!/bin/bash
#
# Initialize POSIX configuration, symlinking configuration files
# to this directory, and shell scripts to ~/scripts.
# This script is idempotent, and ensures that existing dotfiles and
# scripts will no longer be in ~/ or ~/scripts after running
# (to force me to maintain them here).  Before removing anything,
# this script will backup existing files in BACKUP_DIR (defaults to ~/.backup).
# The backup directory is a git repository managed by scripts/backup.
# This script will pass any command line arguments to scripts/backup,
# giving you control over whether to commit the changes or not

function linkfiles() {
    sourcedir=$1
    destprefix=$2

    for file in $(ls $sourcedir); do
        if test -f $sourcedir/$file; then
            ln -s $(pwd)/$sourcedir/$file ${destprefix}${file}
        fi
    done
}

function backup() {
    file=$1

    if test -e $file -o -L $file; then
        scripts/backup $file
        rm -rf $file
    fi
}

# First backup
backup ~/scripts
backup ~/git-completion.bash;

for file in $(ls dotfiles); do
    backup ~/.$file
done

platform=none
if test $(uname) = 'Darwin'; then
    platform=osx
elif test $(uname) = 'Linux'; then
    platform=linux
fi

mkdir ~/scripts
linkfiles dotfiles          ~/.
linkfiles scripts           ~/scripts/
linkfiles scripts/$platform ~/scripts/

wget -O ~/git-completion.bash --no-check-certificate https://github.com/git/git/raw/next/contrib/completion/git-completion.bash

if test $# -gt 0; then
    scripts/backup "$@"
fi
