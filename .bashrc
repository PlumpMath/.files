# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
NC='\e[0m'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Are we on a ssh connection?
[ -n "$SSH_CLIENT" ] && ps1_informer="[${cyan}ssh${NC}]"

function newPrompt {
  # Look for Git status
  if result=$(git diff-files 2>/dev/null) ; then
    branch=$(git branch --color=never | sed -ne 's/* //p')
    if [[ $result != "" ]]; then
      branch=[$red$branch$NC]
    else
      branch=[$blue$branch$NC]
    fi
  else
    unset branch
  fi

  #Are we root? Set the prompt either way.
  if (( $(id -u) == 0 )); then
    PS1="┌[${debian_chroot:+($debian_chroot)}${red}\u${NC}][\h]${branch:+$branch}$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n└# "
  else
    PS1="┌[${debian_chroot:+($debian_chroot)}${green}\u${NC}][\h]${branch:+$branch}$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n└$ "
  fi
}

newPrompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -h'
    alias dir='dir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Allow <C-s> to pass through to shell and programs
stty -ixon -ixoff

# I want my visudos and git commits to be in emacs
export EDITOR="emacsclient -nw -a=\"\""
export VISUAL="emacsclient -a=\"\""

# Fixing not being able to type dead keys in emacs
XMODIFIERS="emacs"

# Tell golang where my workspace is
export GOPATH=$HOME/source/go

# Assume that we have administrative privileges and also add the gopath.
export PATH="$PATH:/usr/sbin:$HOME/source/go/bin:$HOME/.local/bin:/usr/local/heroku/bin"

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it.
shopt -s histappend
# After each command, append to the history file.
PROMPT_COMMAND="newPrompt; history -a; $PROMPT_COMMAND"
