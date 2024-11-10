FROM php:8.2-fpm-alpine

# Build dependencies für xdebug
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    linux-headers

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del .build-deps

# Install nginx and supervisor
RUN apk add --no-cache \
    nginx \
    supervisor

# Supervisor Konfiguration für beide Prozesse
RUN mkdir -p /etc/supervisor.d/
COPY config/supervisor/supervisord.conf /etc/supervisor.d/supervisord.conf

COPY config/nginx/nginx.conf /etc/nginx/nginx.conf

COPY config/php/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY config/php/error_reporting.ini /usr/local/etc/php/conf.d/error_reporting.ini
COPY config/php/php.ini /usr/local/etc/php/php.ini

# PHP-Info / X-Debug bereitlegen
RUN mkdir -p /var/www/system && \
    echo "<?php phpinfo(); ?>" > /var/www/system/php-info.php && \
    echo "<?php xdebug_info(); ?>" > /var/www/system/xdebug-info.php

# Arbeitsverzeichnis
WORKDIR /var/www/html

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor.d/supervisord.conf"]
