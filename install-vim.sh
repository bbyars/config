#! /bin/sh
#
# Setup or update vim, with all plugins, etc
# Borrows heavily from https://github.com/carlhuda/janus
#
function mkvimdir() { [ -d ~/.vim/$1 ] || mkdir ~/.vim/$1; }

function install() {
    for dir in `ls`; do
        if [ -d $dir ]; then
            mkvimdir $dir
            cp -rf $dir/ ~/.vim/$dir/
        fi
    done
}

function gitinstall() {
    repo=`basename $1 .git`
    if [ -d ~/.vim/repos/$repo ]; then
        echo "Updating $repo..."
        cd ~/.vim/repos/$repo
        git pull > /dev/null 2>&1
    else
        echo "Installing $repo..."
        cd ~/.vim/repos
        git clone $1 > /dev/null 2>&1
        cd $repo
    fi

    install
}

function tarinstall() {
    repo=`basename $1 .tar.gz`
    [ -d ~/.vim/repos/$repo ] && rm -rf ~/.vim/repos/$repo

    echo "Installing $repo..."
    mkdir ~/.vim/repos/$repo
    cd ~/.vim/repos/$repo
    curl -O $1 > /dev/null 2>&1
    tar xzf `basename $1` > /dev/null
    cd $repo

    install
}

function fileinstall() {
    cd ~/.vim/$2
    curl -O $1 2> /dev/null
}

# Make sure directories exist
mkvimdir backup
mkvimdir repos

# Install base plugins
gitinstall git://github.com/mileszs/ack.vim.git
gitinstall git://github.com/wincent/Command-T.git
tarinstall http://conque.googlecode.com/files/conque_2.1.tar.gz
gitinstall git://github.com/mattn/gist-vim.git
gitinstall git://github.com/hallettj/jslint.vim.git
gitinstall git://github.com/vim-scripts/matchit.zip.git
gitinstall git://github.com/ddollar/nerdcommenter.git
gitinstall git://github.com/wycats/nerdtree.git
gitinstall git://github.com/vim-scripts/repeat.vim.git
gitinstall git://github.com/vim-scripts/ruby-matchit.git
gitinstall git://github.com/vim-scripts/searchfold.vim.git
gitinstall git://github.com/msanders/snipmate.vim.git
gitinstall git://github.com/ervandew/supertab.git
gitinstall git://github.com/scrooloose/syntastic.git
gitinstall git://github.com/vim-scripts/taglist.vim.git
gitinstall git://github.com/tsaleh/vim-align.git
gitinstall git://github.com/tpope/vim-endwise.git
gitinstall git://github.com/tpope/vim-fugitive.git
gitinstall git://github.com/michaeljsmith/vim-indent-object.git
gitinstall git://github.com/robgleeson/vim-markdown-preview.git
gitinstall git://github.com/tpope/vim-surround.git
gitinstall git://github.com/tpope/vim-unimpaired.git
gitinstall git://github.com/vim-scripts/ZoomWin.git

# Color packs
gitinstall git://github.com/vim-scripts/Color-Sampler-Pack.git
gitinstall git://github.com/wgibbs/vim-irblack.git
gitinstall git://github.com/mrtazz/molokai.vim.git
gitinstall git://github.com/altercation/vim-colors-solarized.git
gitinstall git://github.com/tpope/vim-vividchalk.git

# Syntaxes
gitinstall git://github.com/ajf/puppet-vim.git
gitinstall git://github.com/timcharper/textile.vim.git
gitinstall git://github.com/kchmck/vim-coffee-script.git
gitinstall git://github.com/tpope/vim-cucumber.git
gitinstall git://github.com/tpope/vim-git.git
gitinstall git://github.com/tpope/vim-haml.git
gitinstall git://github.com/pangloss/vim-javascript.git
gitinstall git://github.com/tpope/vim-markdown.git
gitinstall git://github.com/tpope/vim-rails.git
gitinstall git://github.com/taq/vim-rspec.git
gitinstall git://github.com/bdd/vim-scala.git
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/git.vim           syntax
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/gitcommit.vim     syntax
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/gitconfig.vim     syntax
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/gitrebase.vim     syntax
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/gitsendemail.vim  syntax

# Command-T special commands
cd ~/.vim/repos/Command-T
find ruby -name '.gitignore' | xargs rm
cd ruby/command-t
ruby extconf.rb > /dev/null
make clean && make > /dev/null

vim -e -s <<-EOF\n:helptags ~/.vim/doc\n:quit\nEOF

