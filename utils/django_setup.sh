#! /bin/bash

if [ -z ${DOMAIN} ]; then
    echo "error : no domain or empty domain name"
    echo "stopping setup..."
    exit 1
fi

# retrieveing app name from full domain name (e.g: app for app.example.com)
APP_NAME=$(echo ${DOMAIN} | cut -d'.' -f1)
sed -i "s/DOMAIN/${DOMAIN}/g" /${DOMAIN}/config/*
sed -i "s/APP_NAME/${APP_NAME}/g" /${DOMAIN}/config/*
sed -i "s/PORT/${PORT}/g" /${DOMAIN}/config/*

# setting up uswgi
mkdir /${DOMAIN}/run/
chown djangouser:nginx /${DOMAIN}/run/
chmod 770 /${DOMAIN}/run/

# setup existing project or start default django project
if [ -f /${DOMAIN}/code/app/default.app ]; then
    rm -rf /${DOMAIN}/code/app
    su - djangouser -c "cd /${DOMAIN}/code/ && django-admin.py startproject ${APP_NAME}"
    echo "Your project has been initialized in /${DOMAIN}/code/${APP_NAME}/"
else
    mv /${DOMAIN}/code/app /${DOMAIN}/code/${APP_NAME}
    echo "Your project has been moved to /${DOMAIN}/code/${APP_NAME}/"
fi
chown -R djangouser:nginx /${DOMAIN}/code/${APP_NAME}/
chmod u+x,g+x /${DOMAIN}/code/

# keep domain name
echo "${DOMAIN}" > /.domain
