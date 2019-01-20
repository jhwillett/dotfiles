# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

case $- in
    *i*) ;;
      *) return;;
esac

echo X

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

echo Y

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

echo Y1

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

echo Y2

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

echo Y3

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
echo Y4

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    echo Y41
  if [ -f /usr/share/bash-completion/bash_completion ]; then
      echo Y42
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
      echo Y43
    . /etc/bash_completion
  fi
  echo Y44
fi

echo Y5

# Stuff to keep JHW sane.
#
export EDITOR=emacs

echo Y51

echo Y52
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
echo Y53

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo Y6

############################################################################
# JHW stuff follows
############################################################################

echo Z

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

echo Y7

[ -d ~/bin ]                    && export PATH="$PATH:~/bin"
[ -d /usr/local/sbin ]          && export PATH="/usr/local/sbin:$PATH"
[ -d /usr/local/bin ]           && export PATH="/usr/local/bin:$PATH"
[ -d ~/Library/Python/2.7/bin ] && export PATH="$PATH:~/Library/Python/2.7/bin"
[ -d ~/ali-tools/bin ]          && export PATH="$PATH:~/ali-tools/bin"

[ -s "$HOME/.git-completion.bash" ] && source "$HOME/.git-completion.bash"
[ -s "$HOME/.pw_env_jhw" ]          && source "$HOME/.pw_env_jhw"

# Enable simple CLIs:
#
#   ssh ubuntu@ec2-54-89-21-101.compute-1.amazonaws.com
#
#   ssh ec2-user@ali-jenkins.com
#
#[[ -f "$HOME/.ssh/jhw-hacky-keypair-ii.pem" ]] && ssh-add "$HOME/.ssh/jhw-hacky-keypair-ii.pem"
#[[ -f "$HOME/.ssh/jenkins.pem" ]] && ssh-add "$HOME/.ssh/jenkins.pem"

echo Y8

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

export NVM_DIR="$HOME/.nvm"
[[ -f "/usr/local/opt/nvm/nvm.sh" ]] && source "/usr/local/opt/nvm/nvm.sh"

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

echo Y9
