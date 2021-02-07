#!/bin/sh

VENDOR_PATH="${ROOT_PATH}vendor";
ROOT_LENGTH=${#ROOT_PATH};

if [ ! $ROOT_LENGTH -gt 0 ]
then
  echo "Project ROOT not specified. Please set the 'ROOT_PATH' env variable pointing to the root of the service.";
  exit 1;
fi

cd $ROOT_PATH;

if [ ! -d "$VENDOR_PATH" ]
then

  # Run Composer install
  composer install --verbose --no-progress 2>&1
fi

if [ ! -f "${ROOT_PATH}.env" ]
then
  cat ./.env.example > .env
fi

php artisan key:generate

chmod -R 777 "$VENDOR_PATH";

service nginx start
php-fpm