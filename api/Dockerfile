FROM portmone/php-fpm-nginx-oracle-mysql:7.4.1

COPY conf/nginx/nginx.conf /etc/nginx/
COPY conf/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY conf/nginx/app.conf /etc/nginx/conf.d/app.conf
COPY conf/php-fpm/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY conf/php-fpm/php.ini /usr/local/etc/php/php.ini
COPY conf/scripts/* /scripts/

RUN chmod 755 -R /scripts

WORKDIR /srv
COPY ./src /srv

RUN mkdir -p /srv/storage/logs \
 && mkdir -p /srv/storage/framework/aspect \
 && mkdir -p /srv/storage/framework/sessions \
 && mkdir -p /srv/storage/framework/views \
 && mkdir -p /srv/storage/framework/cache \
 && mkdir -p /srv/storage/b2b/merchant \
 && touch /srv/storage/logs/application.log

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
		 --with-freetype \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install -o -f xdebug \
    &&  docker-php-ext-enable xdebug

ENV LD_LIBRARY_PATH=/usr/local/lib/php/extensions

# Run Composer install
RUN composer install --verbose --no-suggest --no-progress 2>&1

RUN chown nginx:nginx -R /srv/storage \
 && chown nginx:nginx -R /srv/bootstrap/cache

ENTRYPOINT ["/bin/bash", "/scripts/entrypoint.sh"]
