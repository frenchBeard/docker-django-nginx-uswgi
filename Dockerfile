FROM frenchbeard/centos-dev:latest

MAINTAINER frenchBeard <chablecorre@gmail.com>

# Default variables for futur containers
ENV DOMAIN  app.example.com
ENV PORT    8080

# Installing uswgi & nginx
RUN yum install -y python-pip python-setuptools nginx gcc python-devel unzip wget --enablerepo=epel
RUN pip install uwsgi

# Adding user to manage application
RUN mkdir -p /${DOMAIN}/run
RUN adduser --home=/${DOMAIN}/code/ -u 1000 djangouser

# Setting up configuration
ADD config  /${DOMAIN}/config
ADD app     /${DOMAIN}/code/app

RUN mv  /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
RUN ln -s /${DOMAIN}/config/django.params /etc/nginx/conf.d/
RUN ln -s /${DOMAIN}/config/nginx.conf /etc/nginx/nginx.conf

# Install django and requirements
RUN pip install -r /${DOMAIN}/config/requirements.txt

# Adding utils
ADD utils       /utils
RUN chmod 700   /utils/*

RUN /utils/django_setup.sh

# Make nginx default log location mountable
VOLUME ["/var/log/nginx"]

EXPOSE ${PORT}

CMD ["/utils/django_run.sh"]
