#!/usr/bin/env bash
#
# perms.sh
#
# Gives a user access to a bunch of our Heroku environments.
#
# author: jhw@prosperworks.com
# incept: 2016-12-13
#

#EMAILS="`heroku members --org prosperworks | sed 's/\.com.*/.com/g' | grep -v achou`"
EMAILS="achou@prosperworks.com"
APPS="ali-integration ali-integration-beta ali-integration-beta-public ali-integration-delta ali-integration-epsilon ali-integration-gamma ali-integration-kappa ali-integration-public ali-integration-theta ali-staging ali-staging-public ali-staging-watchman onebox-pw ali-integration-001 ali-integration-002 ali-integration-003 ali-integration-004 ali-integration-005 ali-integration-006 ali-integration-007"
#APPS="ali-production ali-production-public ali-production-watchman"

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
for app in $APPS
do
    echo ======================
    echo heroku access --app $app
    echo ----------------------
    heroku access --app $app
done
heroku members --org prosperworks
