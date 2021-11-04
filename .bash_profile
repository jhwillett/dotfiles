
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f ~/.bashrc ]
then
    source ~/.bashrc ]
fi

if [ -e /Users/jhw/.nix-profile/etc/profile.d/nix.sh ]
then
    source /Users/jhw/.nix-profile/etc/profile.d/nix.sh
fi

if [ -f "$HOME/.cargo/env" ]
then
    source "$HOME/.cargo/env"
fi

if [ -x "/opt/homebrew/bin/brew" ]
then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
