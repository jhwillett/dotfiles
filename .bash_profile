
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# JHW stuff follows
#
[[ -d "$HOME/bin" ]] && export PATH="$PATH:$HOME/bin"
export HISTFILESIZE=250000
export EDITOR=emacs
#
# $HOME/bin"
if [[ -f "$HOME/bin/git-prompt.sh" ]]; then
    source "$HOME/bin/git-prompt.sh"
    export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
fi
#
# JHW stuff preceeds
