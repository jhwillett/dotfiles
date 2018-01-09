#/bin/bash
#

set -x

which elasticsearch && elasticsearch -version

brew unlink elasticsearch
brew unlink elasticsearch@2.4
if [ "6.1" == "$1" ]
then
    brew link elasticsearch --force --overwrite
elif [ "2.4" == "$1" ]
then
    brew link elasticsearch@2.4 --force --overwrite
else
    echo "UNRECOGNIZED VERSION: $1"
    exit 1
fi

which elasticsearch && elasticsearch -version
