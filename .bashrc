# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

case $- in
    *i*) ;;
      *) return;;
esac

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
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

############################################################################
# JHW stuff follows
############################################################################

# Emacs all the way added by jhw 2015-04-14.
#
export EDITOR="emacs"

# Huge HISTFILESIZE by jhw 2015-06-05.
#
export HISTSIZE=50000
export HISTFILESIZE=50000

# hgrep() per by jhw 2015-04-14.
#
# hgrep needs to be a function, else 'history' doesn't mean what you
# think it means.
#
function hgrep()
{
    if [[ -n "$@" ]]; then
        history | grep "$@"
    else
        history
    fi
}

# git-prompt added by jhw 2015-04-14 per:
#
#  https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
#
[[ -s "$HOME/.git-prompt.sh" ]] && source "$HOME/.git-prompt.sh"
export PS1='\h:\W \u\$ '                           # default
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '     # per git-prompt.sh

if uname | grep -i Darwin > /dev/null
then
    export PS1='[\u@mac \w$(__git_ps1 " (%s)")]\$ ' # jwillett tweak
fi

[ -d /usr/local/sbin ]          && export PATH="/usr/local/sbin:$PATH"
[ -d /usr/local/bin ]           && export PATH="/usr/local/bin:$PATH"
[ -d ~/Library/Python/3.9/bin ] && export PATH="$PATH:$HOME/Library/Python/3.9/bin"
[ -d ~/Library/Python/2.7/bin ] && export PATH="$PATH:$HOME/Library/Python/2.7/bin"
[ -d ~/bin ]                    && export PATH="$PATH:$HOME/bin"

[ -s "$HOME/.git-completion.bash" ] && source "$HOME/.git-completion.bash"
[ -s "$HOME/.pw_env_jhw" ]          && source "$HOME/.pw_env_jhw"

# protoc and other tools will not expand ~ in GOPATH, so we use $HOME
#
if [ -d "$HOME/go" ]
then
    export GOPATH="$HOME/go"
    if [ -d "$GOPATH/bin" ]
    then
        export PATH="$PATH:$GOPATH/bin"
    fi
fi

############################################################################
# JHW stuff preceeds
############################################################################

# set JAVA_HOME per
#
# https://sites.google.com/a/mobiusmediagroup.com/eli/engineering/getting-started
#
if [ -d /usr/libexec/java_home ]
then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

# Make tab completion work with kubectl commands.
#
if which kubectl > /dev/null
then
    source <(kubectl completion bash)
fi

# Some GCP utilities developed locally.
#
if [ -f "$HOME/helm-config/scripts/kubernetes-shortcuts.shell" ]
then
    source "$HOME/helm-config/scripts/kubernetes-shortcuts.shell"
    source <(kubectl completion bash)
fi

export PYTHONSTARTUP=$HOME/.pythonrc

if [ -f "$HOME/.cargo/env" ]
then
    source "$HOME/.cargo/env"
fi

if [ -x "/opt/homebrew/bin/brew" ]
then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
