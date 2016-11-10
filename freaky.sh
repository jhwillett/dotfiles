#!/bin/sh
#

SUBDIRS='pgcomparator queryator raider s3grooming'

for dir in $SUBDIRS ; do
    echo git clone git@github.com:ProsperWorks/ALI.git sacrificial-ali-$dir
done

