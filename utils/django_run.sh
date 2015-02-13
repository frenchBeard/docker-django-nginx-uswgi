#! /bin/bash

# Background uwsgi
DOMAIN=$(cat /.domain)
uwsgi --uid djangouser --gid nginx --ini /${DOMAIN}/config/django.ini

# Start nginx
exec nginx
