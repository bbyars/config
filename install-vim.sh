#! /bin/sh
#
# Clean install vim, with all plugins
# Borrows heavily from https://github.com/carlhuda/janus
#
STRIP_PATTERN='[-.]*vim-*'

function gitinstall() {
    repo=$(basename $1 .git | sed s/$STRIP_PATTERN//)
    echo "Installing $repo..."
    cd ~/.vim/bundle
    git clone $1 $repo > /dev/null 2>&1
}

function tarinstall() {
    repo=$(basename $1 .tar.gz | sed s/$STRIP_PATTERN//)
    echo "Installing $repo..."
    cd ~/.vim/bundle
    curl -O $1 > /dev/null 2>&1
    tar xzf $(basename $1) > /dev/null
}

function fileinstall() {
    test -d ~/.vim/bundle/$2 || mkdir ~/.vim/bundle/$2
    cd ~/.vim/bundle/$2
    if test -z $3; then
        curl -O $1 2> /dev/null
    else
        curl -o $3 $1 2> /dev/null
    fi
}

mkdir ~/.vim/backup
mkdir ~/.vim/bundle

# Install pathogen
echo "Installing pathogen..."
git clone https://github.com/tpope/vim-pathogen.git > /dev/null 2>&1
mv vim-pathogen/* ~/.vim
rm -rf vim-pathogen

# Install base plugins
gitinstall https://github.com/mileszs/ack.vim.git
gitinstall https://github.com/wincent/Command-T.git
tarinstall http://conque.googlecode.com/files/conque_2.1.tar.gz
fileinstall http://www.vim.org/scripts/download_script.php?src_id=12150 hexHighlight hexHighlight.vim
gitinstall https://github.com/mattn/gist-vim.git
gitinstall https://github.com/sjl/gundo.vim.git
gitinstall https://github.com/hallettj/jslint.vim.git
gitinstall https://github.com/vim-scripts/matchit.zip.git
gitinstall https://github.com/ddollar/nerdcommenter.git
gitinstall https://github.com/wycats/nerdtree.git
gitinstall https://github.com/vim-scripts/repeat.vim.git
gitinstall https://github.com/vim-scripts/ruby-matchit.git
gitinstall https://github.com/vim-scripts/searchfold.vim.git
gitinstall https://github.com/msanders/snipmate.vim.git
gitinstall https://github.com/ervandew/supertab.git
gitinstall https://github.com/scrooloose/syntastic.git
gitinstall https://github.com/godlygeek/tabular.git
gitinstall https://github.com/vim-scripts/taglist.vim.git
gitinstall https://github.com/tpope/vim-endwise.git
gitinstall https://github.com/tpope/vim-fugitive.git
gitinstall https://github.com/michaeljsmith/vim-indent-object.git
gitinstall https://github.com/robgleeson/vim-markdown-preview.git
gitinstall https://github.com/tpope/vim-surround.git
gitinstall https://github.com/tpope/vim-unimpaired.git
gitinstall https://github.com/vim-scripts/ZoomWin.git

# Color packs
gitinstall https://github.com/vim-scripts/Color-Sampler-Pack.git
gitinstall https://github.com/wgibbs/vim-irblack.git
gitinstall https://github.com/mrtazz/molokai.vim.git
gitinstall https://github.com/altercation/vim-colors-solarized.git
gitinstall https://github.com/tpope/vim-vividchalk.git

# Syntaxes
gitinstall https://github.com/ajf/puppet-vim.git
gitinstall https://github.com/timcharper/textile.vim.git
gitinstall https://github.com/kchmck/vim-coffee-script.git
gitinstall https://github.com/tpope/vim-cucumber.git
gitinstall https://github.com/tpope/vim-git.git
gitinstall https://github.com/tpope/vim-haml.git
gitinstall https://github.com/pangloss/vim-javascript.git
gitinstall https://github.com/tpope/vim-markdown.git
gitinstall https://github.com/tpope/vim-rails.git
gitinstall https://github.com/taq/vim-rspec.git
gitinstall https://github.com/bdd/vim-scala.git
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/git.vim           git
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/gitcommit.vim     git
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/gitconfig.vim     git
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/gitrebase.vim     git
fileinstall http://ftp.vim.org/pub/vim/runtime/syntax/gitsendemail.vim  git

# Peepopen if it exists
if test -d /Applications/PeepOpen.app/Contents/Resources/Support/vim-peepopen; then
    echo "Installing peepopen..."
    cp -r /Applications/PeepOpen.app/Contents/Resources/Support/vim-peepopen ~/.vim/bundle
fi

# Command-T special commands
cd ~/.vim/bundle/Command-T
find ruby -name '.gitignore' | xargs rm
cd ruby/command-t
ruby extconf.rb > /dev/null
make clean && make > /dev/null

