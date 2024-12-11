FROM php:8.2-fpm-alpine

# Install xdebug with dependencies
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS linux-headers && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    apk del .build-deps

# Install nginx and supervisor
RUN apk add --no-cache nginx supervisor

# COPY Config
COPY config/ /

# PHP-Info / X-Debug and additional mime type
RUN mkdir -p /var/www/system && \
    echo "<?php phpinfo(); ?>" > /var/www/system/php-info.php && \
    echo "<?php xdebug_info(); ?>" > /var/www/system/xdebug-info.php && \
    sed -i 's/\(application\/javascript.*\);/\1 mjs;/' /etc/nginx/mime.types

# Arbeitsverzeichnis
WORKDIR /var/www/html

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor.d/supervisord.conf"]
