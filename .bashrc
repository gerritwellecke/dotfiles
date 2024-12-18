# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# to stop Mac from bothering me about bash
#export BASH_SILENCE_DEPRECATION_WARNING=1

export CLICOLOR=1

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# parse git branch
parse_git_branch() {
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null \
	| sed -e 's/\(.*\)/ \(\1\)/')
    echo "$branch$(ahead_behind)"
}

# get commits head/behind
ahead_behind() {
    curr_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null);
    curr_remote=$(git config branch.$curr_branch.remote 2> /dev/null);
    git rev-list --left-right --count $curr_branch...$curr_remote/$curr_branch \
	2> /dev/null \
	| tr -s '\t' '|' \
	| sed -e 's/\(.*\)/\[\1\]/';
}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Make chaning directories easy
shopt -s autocd

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[31m\]\$(parse_git_branch)\[\033[00m\]\$ "
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### MY STUFF ###################################################################
# vim mode
set -o vi

export VISUAL=nvim
export EDITOR=$VISUAL

set bell-style none

# GPG automatic signing 
# export GPG_TTY=$(tty)

# add platformIO to path
#export PATH=$PATH:~/.platformio/penv/bin
# add speedtest-cli to path
#export PATH=$PATH:~/.local/bin

## TeX Live
#export PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH
#export MANPATH=/usr/local/texlive/2021/texmf-dist/doc/man:$MANPATH
#export INFOPATH=/usr/local/texlive/2021/texmf-dist/doc/info:$INFOPATH

# make gnuplot work with TeX Live
#export TEXINPUTS=/usr/share/texmf/tex/:$TEXINPUTS

export SHELL='/opt/homebrew/bin/bash'

# C/C++ Libraries from homebrew
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
export CXX="clang++"
export CXXFLAGS="$CPPFLAGS -I/opt/homebrew/opt/llvm/include/c++/v1 -I/opt/homebrew/include"

# recommendation from stack overflow:
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib

# git autocompletion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 2>/dev/null ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end


# pyenv -- this should be last
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
