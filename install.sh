#! /bin/sh

function backup() {
    [ -d ~/.backup ] || mkdir ~/.backup
    if [ -e ~/.backup/$1 ]; then
        # Assumes it was previously backed up, and we've
        # just re-run this script; leave old backup in place
        rm ~/$1
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
curl https://github.com/git/git/raw/next/contrib/completion/git-completion.bash > ~/git-completion.bash 2>&1 /dev/null

echo
echo "Installing vim scripts"
./install-vim.sh

