#!/usr/bin/env bash
#
# perms.sh
#
# Gives a user access to a bunch of our Heroku environments.
#
# author: jhw@prosperworks.com
# incept: 2016-12-13
#

EMAILS="alvin@prosperworks.com"
APPS="ali-integration-beta ali-integration-beta-public ali-integration-delta ali-integration-epsilon ali-integration-gamma ali-integration-kappa ali-integration-public ali-integration-theta ali-production ali-production-public ali-production-public ali-production-watchman ali-staging ali-staging-public onebox-pw"

for email in $EMAILS
do
    heroku members --org prosperworks | grep $email || heroku members:add $email --org prosperworks --role member
    for app in $APPS
    do
        heroku access:add $email --app $app --permissions deploy,operate,view || heroku access:update $email --app $app --permissions deploy,operate,view
    done
done

# Report on total status for review.
#
heroku members --org prosperworks
for app in $APPS
do
    echo ======================
    echo heroku access --app $app
    echo ----------------------
    heroku access --app $app
done
