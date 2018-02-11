FROM php:7.1-cli

RUN apt-get update && apt-get -y install git \
    && curl -Ss https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer \
    && git clone https://github.com/TwilioDevEd/sdk-starter-php

WORKDIR sdk-starter-php

RUN touch webroot/.env \
    && composer install

EXPOSE 8000

CMD ["php", "-S", "0.0.0.0:8000", "-t", "webroot"]
