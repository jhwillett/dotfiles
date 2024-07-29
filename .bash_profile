
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f ~/.bashrc ]
then
    source ~/.bashrc ]
fi

if [ -e /Users/jhw/.nix-profile/etc/profile.d/nix.sh ]
then
    source /Users/jhw/.nix-profile/etc/profile.d/nix.sh
fi

# Stuff done or suggested by 'brew install openjdk'
#
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"
