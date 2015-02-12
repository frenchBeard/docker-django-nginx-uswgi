# docker-django-usgi-nginx

A dockerfile to run either an empty django project, or your own app copied in the “app” folder.
Based on an up-to-date CentOS 7 image.

## Managing the image

to create the image :
```
docker build -t $USER/django-nginx-uwsgi .
```

to run the image once created (with default 8080 port bound to host):
```
docker run -d -p 8080:8080 $USER/django-nginx-uwsgi
```
