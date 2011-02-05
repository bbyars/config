export PATH=$PATH:/opt/local/bin:~/Scripts
export EDITOR=vi
export MANPATH=$MANPATH:/opt/local/share/man
export INFOPATH=$INFOPATH:/opt/local/share/info

export CLICOLOR=true
export LSCOLORS=gxfxcxdxbxegedabadacad

export PS1="\W$ "

alias ll="ls -al"
alias mysql="/opt/local/bin/mysql5"
alias mysqlstart="sudo /opt/local/bin/mysqld_safe5 &"
alias mysqlstop="sudo /opt/local/bin/mysqladmin5 -u root -p shutdown"
alias dirs="ls -al | grep '^d'"
alias wiki="python ~/bin/wikidpad/WikidPad.py > /dev/null &"

alias gs="git status"

export GEMDIR=`gem env gemdir`

gemdoc() {
  open $GEMDIR/doc/`$(which ls) $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
}

_gemdocomplete() {
  COMPREPLY=($(compgen -W '$(`which ls` $GEMDIR/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _gemdocomplete gemdoc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
