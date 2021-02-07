FROM php:7.4.14-fpm

RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y git

RUN wget https://curl.haxx.se/ca/cacert.pem \
    && curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '$(wget -q -O - https://composer.github.io/installer.sig)') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer --quiet --version=2.0.8


WORKDIR /var/www/html
COPY ./src /var/www/html

RUN mkdir -p /var/www/html/storage/logs \
 && mkdir -p /var/www/html/storage/framework/aspect \
 && mkdir -p /var/www/html/storage/framework/sessions \
 && mkdir -p /var/www/html/storage/framework/views \
 && mkdir -p /var/www/html/storage/framework/cache

RUN chmod -R 775 /var/www/html/storage/logs
## Run Composer install
#RUN composer install --verbose --no-suggest --no-progress 2>&1


RUN apt-get update \
    && apt-get install -y procps nginx vim zlib1g-dev libpng-dev libjpeg-dev libonig-dev zip unzip libzip-dev \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install gd mbstring pdo pdo_mysql \
    && docker-php-ext-install zip

RUN mkdir /etc/nginx/ssl
COPY ./conf/nginx/nginx.crt /etc/nginx/ssl/nginx.crt
COPY ./conf/nginx/nginx.key /etc/nginx/ssl/nginx.key
COPY ./conf/php-fpm/default.ini /usr/local/etc/php/conf.d/default.ini

#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=UA/ST=Kiev/L=Kiev/O=CrioZone"

RUN mkdir -p /scripts
COPY ./conf/scripts/entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

ENTRYPOINT ["/bin/sh", "/scripts/entrypoint.sh", "${ROOT_PATH}"]
