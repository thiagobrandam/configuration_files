## aliases
alias ..='cd ..'
alias ...='cd ../..'
alias la='ls -la'
alias grep='grep --color=always'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias firefox='open -a Firefox'
alias safari='open -a Safari'
alias flushdns='dscacheutil -flushcache'

## bash colors
export CLICOLOR=1
export LSCOLORS=ExGxxxxxbxxxxxxxxxxxxx

## git stuff
# Shows git information on the prompt
if [[ -s '/usr/local/etc/bash_completion.d/git-prompt.sh' ]]; then
  source '/usr/local/etc/bash_completion.d/git-prompt.sh'
fi

# Adds completion for git functions
if [[ -s '/usr/local/etc/bash_completion.d/git-completion.bash' ]]; then
  source '/usr/local/etc/bash_completion.d/git-completion.bash'
fi

## prompt format
export PS1='\[\033[01;32m\]\u@\h$(__git_ps1 " (%s)")\[\033[01;34m\] \W \$\[\033[00m\] '

## mysql stuff
export PATH=/usr/local/mysql/bin:$PATH
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/mysql/lib/"
export MYSQL_HISTFILE=/dev/null
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig:$PKG_CONFIG_PATH

## custom path
export PATH=~/bin:$PATH

## homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

## go
export GOPATH=$HOME/projects/go
export PATH=$PATH:$GOPATH/bin

## python
export PATH=$PATH:$HOME/Library/Python/2.7/bin/

# goroot based install
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# homebrew postgres
export PATH=/usr/local/opt/postgresql@9.4/bin:$PATH

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# rvm
export PATH="$PATH:$HOME/.rvm/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# haskell
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

## rvm stuff
# This loads RVM into a shell session
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
fi

## history stuff
shopt -s histappend
export HISTSIZE=1000
export HISTTIMEFORMAT="| %d/%m/%Y %T | "
if [ -z ${PROMPT_COMMAND+x} ]; then
  export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"
fi
export HISTCONTROL=erasedups
export HISTIGNORE="&:cl:x"

## generic stuff
# Editor that opens when asked for input
export EDITOR=code

# This makes all Perl scripts decode @ARGV as UTF‑8 strings,
# and sets the encoding of all three of stdin, stdout, and
# stderr to UTF‑8. Both these are global effects, not lexical ones.
export PERL_UNICODE=AS

# do not check for mails in bash
unset MAILCHECK

function reload {
  source "$HOME/.bash_profile"
}

function gitchangelog {
  if [ $# -lt 1 ]; then
    echo 'Usage: gitchangelog [ref]'
    return 1
  else
    git log  $1..HEAD --oneline --decorate
  fi
}

function pg_restore_without_bullshit {
  if [ $# -lt 2 ]; then
    echo 'Usage: pg_restore_without_bullshit [db] [filename]'
    return 1
  else
    pg_restore --verbose --clean --no-acl --no-owner -d $1 $2 -U thiago -h localhost -W
  fi
}

function dirsize {
  find . -maxdepth 1 -type d -mindepth 0 -exec du -hs {} \; | gsort -hr
}

# remove docker containers
function rmconts {
  docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm
}

# https://coderwall.com/p/tsfiya/rails-alias_method_chain-for-bash
function decorate {
  local base=$1
  local feature=$2
  local undecorated="${base}_without_${feature}"
  local decorated="${base}_with_${feature}"

  # Define $undecorated with $base's body
  eval "$(echo 'function' ${undecorated}; declare -f $base | tail -n +2)"

  # Define $base with $decorated's body
  eval "$(echo 'function' ${base}; declare -f $decorated | tail -n +2)"
}

# function cd_with_docker {
#   cd_without_docker "$@"
#   case $PWD in
#     /Users/thiago/projects/querobolsa) . ./.docker;;
#   esac
# }

# decorate cd docker

# BEGIN Ruboto setup
source ~/.rubotorc
# END Ruboto setup

source ~/.homebrew_token

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

export ERL_AFLAGS="-kernel shell_history enabled"
