# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
#
shopt -s histappend

# Save many days' worth of history.
#
HISTSIZE=50000
HISTFILESIZE=50000

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR="emacs"

export LESS=R

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

# per rustup:
#
if [ -d "$HOME/.cargo/bin" ]
then
    export PATH="$PATH:$HOME/.cargo/bin"
    if [ -x "$HOME/.cargo/bin" ]
    then
       source "$HOME/.cargo/env"
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

if [ -d "$HOME/.pythonrc" ]
then
    export PYTHONSTARTUP="$HOME/.pythonrc"
fi

# This may break the beancount installed by Homebrew.
#
# Unfortunately, this may have gotten some cargo-ndk and/or Android Studio stuff
# to work correctly.
#
# TODO: WTF with having a nice clean python3 installation?
#
#if [[ -d "$(brew --prefix)/opt/python@3/libexec/bin" ]]
#then
#    export PATH="$(brew --prefix)/opt/python@3/libexec/bin:$PATH"
#    echo ".bashrc found: PATH to python@3"
#fi

if [ -f "$HOME/.cargo/env" ]
then
    source "$HOME/.cargo/env"
fi

if [ -x "/opt/homebrew/bin/brew" ]
then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Per https://kylemayes.github.io/vulkanalia/development_environment.html, after
# installing vulkansdk-macos-1.3.290.0.dmg from https://vulkan.lunarg.com/ I
# want to include a call to their setup-env.sh in my environment.
#
VULKAN_HOME="$HOME/VulkanSDK/1.3.290.0"
if [ -d "$VULKAN_HOME" ]
then
    export VULKAN_HOME
    if [ -f "$VULKAN_HOME/setup-env.sh" ]
    then
        source "$VULKAN_HOME/setup-env.sh"
    fi
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable
# change.
#
# TODO jhw: @hy do we want $HOM/.rvm/bin last instead of first in PATH?
#
# Also load RVM into a shell session *as a function*.
#
if false
then
    if [[ -d "$HOME/.rvm/bin" ]]
    then
        export PATH="$PATH:$HOME/.rvm/bin"
    fi
    if [[ -s "$HOME/.rvm/scripts/rvm" ]]
    then
        source "$HOME/.rvm/scripts/rvm"
    fi
fi

# Trying ruby from:
#
#   brew install ruby-install
#   ruby-install ruby 3.3
#
if [[ -d "$HOME/.rubies/ruby-3.3.4/bin" ]]
then
    export PATH="$HOME/.rubies/ruby-3.3.4/bin:$PATH"
fi

if [[ -d "/usr/local/share/android-commandlinetools/cmdline-tools" ]]
then
    export ANDROID_SDK_ROOT="/usr/local/share/android-commandlinetools"
    echo ".bashrc found: ANDROID_SDK_ROOT=\"$ANDROID_SDK_ROOT\""
    if [[ -d "$ANDROID_SDK_ROOT/emulator" ]]
    then
        export PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
        echo ".bashrc found: PATH to Android emulator tools"
    fi
    if [[ -d "$ANDROID_SDK_ROOT/platform-tools" ]]
    then
        export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
        echo ".bashrc found: PATH to Android adb tools"
    fi
fi
if [[ -n "$ANDROID_SDK_ROOT" ]] && [[ -d "$ANDROID_SDK_ROOT/ndk/27.0.12077973" ]]
then
    export ANDROID_NDK_HOME="$ANDROID_SDK_ROOT/ndk/27.0.12077973"
    export NDK_HOME="$ANDROID_NDK_HOME"
    echo ".bashrc found: ANDROID_NDK_HOME=\"$ANDROID_NDK_HOME\""
fi
if [[ -n "$ANDROID_SDK_ROOT" ]] && [[ -d "$ANDROID_SDK_ROOT/build-tools/35.0.0" ]]
then
    export PATH="$ANDROID_SDK_ROOT/build-tools/35.0.0:$PATH"
    echo ".bashrc found: PATH to Android SDK build tools"
fi

if [[ -d "/usr/local/opt/llvm/bin" ]]
then
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    echo ".bashrc found: PATH to llvm"
fi

if [[ -d "$HOME/xbuild/target/debug" ]]
then
    export PATH="$HOME/xbuild/target/debug:$PATH"
    echo ".bashrc found: PATH to locally-built xbuild"
fi
