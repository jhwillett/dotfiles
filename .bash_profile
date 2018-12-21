
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

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
