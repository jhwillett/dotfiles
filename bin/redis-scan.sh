#!/usr/bin/env bash
#
# redis-scan.sh
#
# Check Redis usage in all integration environments.
#
# author: jhw@prosperworks.com
# incept: 2017-02-13
#

set -euo pipefail

APPS="`heroku apps --org prosperworks | grep integration | grep -v public | grep -v watchman | grep -v kappa`"

for APP in $APPS
do
    URL=`heroku config:get --app $APP REDISCLOUD_URL`
    AUTH=`echo $URL | sed 's/.*:\(.*\)@.*/\1/g'`
    HOST=`echo $URL | sed 's/.*@\(.*\):.*/\1/g'`
    PORT=`echo $URL | sed 's/.*:\(.*\)$/\1/g'`
    heroku addons:info --app $APP rediscloud | grep -e Attachment -e Plan
    echo -n "Used:         "
    echo info | redis-cli -a $AUTH -h $HOST -p $PORT | grep used_memory: | sed 's/.*://g'
    heroku addons:downgrade --app $APP rediscloud rediscloud:100
done
