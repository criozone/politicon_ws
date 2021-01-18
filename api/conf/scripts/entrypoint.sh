#!/bin/bash

mkdir -p /srv/storage/logs
mkdir -p /srv/storage/framework/aspect
mkdir -p /srv/storage/framework/cache/data
mkdir -p /srv/storage/app/public
rm -rf /srv/bootstrap/cache/*.php
rm -rf /srv/storage/framework/aspect/_annotations/*
rm -rf /srv/storage/framework/aspect/_aspect/*

php artisan storage:link
php artisan config:cache
php artisan route:cache
php artisan storage:link

chown nginx:nginx -R /srv/bootstrap
chown nginx:nginx -R /srv/storage

