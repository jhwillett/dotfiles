#/bin/bash
#
# Tricks Homebrew into switching between 2 different versions of ES.
#

set -x

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

elasticsearch -version
