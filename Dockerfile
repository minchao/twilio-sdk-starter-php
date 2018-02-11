FROM php:7.1-apache

ENV APACHE_DOCUMENT_ROOT /sdk-starter-php/webroot

RUN set -xe \
# Changing DocumentRoot
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
    && apt-get update && apt-get install -y \
        git \
        zlib1g-dev \
    && docker-php-ext-install zip \
    && curl -Ss https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer \
# Download sdk-starter-php project
    && cd / \
    && git clone https://github.com/TwilioDevEd/sdk-starter-php

WORKDIR /sdk-starter-php

RUN touch webroot/.env \
    && composer install
