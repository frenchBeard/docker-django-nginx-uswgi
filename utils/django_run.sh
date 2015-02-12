#! /bin/bash

# Background uswgi
DOMAIN=$(cat /.domain)
uswgi --ini /${DOMAIN}/config/django.ini --uid 1000 --gid 1000 &

# Start nginx
exec nginx
