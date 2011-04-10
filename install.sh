#! /bin/sh

function backup() {
    [ -d ~/.backup ] || mkdir ~/.backup
    mv ~/$1 ~/.backup
}

echo "Symlinking dot-files to this directory"
echo "Existing dot-files will be moved to ~/.backup"
for file in .gemrc .gitconfig .gitk .gvimrc .inputrc .irbrc .profile .vimrc; do
    [ -f ~/$file ] && backup $file
    [ -L ~/$file ] && rm ~/$file
    ln -s `pwd`/$file ~/$file
done

echo
echo "Downloading git-completion.bash"
curl https://github.com/git/git/raw/next/contrib/completion/git-completion.bash > ~/git-completion.bash 2>&1 /dev/null

echo
echo "Installing vim scripts"
./install-vim.sh

