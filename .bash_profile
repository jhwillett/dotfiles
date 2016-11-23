
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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
export PS1='[\u@mac \w$(__git_ps1 " (%s)")]\$ '    # jwillett tweak

# git-completion added by jhw 2015-04-28 per:
#
#  https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
#
[[ -s "$HOME/.git-completion.bash" ]] && source "$HOME/.git-completion.bash"

# ~/bin added to PATH by jhw 2015-04-13:
#
if [ -d ~/bin ]; then
    export PATH="$PATH:~/bin"
fi

# ~/Library/Python/2.7/bin added to PATH by jhw 2015-08-13:
#
if [ -d ~/Library/Python/2.7/bin ]; then
    export PATH="$PATH:~/Library/Python/2.7/bin"
fi

# Load some private stuff.
#
[[ -s "$HOME/.pw_env_jhw" ]] && source "$HOME/.pw_env_jhw"

############################################################################
# JHW stuff preceeds
############################################################################

# set JAVA_HOME per https://sites.google.com/a/mobiusmediagroup.com/eli/engineering/getting-started
export JAVA_HOME=`/usr/libexec/java_home`
