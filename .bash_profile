
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f ~/.bashrc ]
then
    source ~/.bashrc ]
fi
if [ -e /Users/jhw/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jhw/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
