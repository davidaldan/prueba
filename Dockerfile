FROM php:7.2-fpm-alpine

RUN apk add --no-cache curl git unzip vim zip libzip-dev
RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install zip

RUN apk add libpng libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev gd && docker-php-ext-install gd bcmath

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN set -eux; \
    apk update; \
    apk add libxml2-dev; \
    apk add php7-soap;

RUN apk add --no-cache postgresql-dev; \
    docker-php-ext-install soap; \
    docker-php-ext-enable soap;

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 9001

CMD ["php-fpm"]

#FROM php:7.2-apache

#RUN apt-get update && apt-get install -y \
#        zlib1g-dev \
#        libicu-dev \
#        libxml2-dev \
#        libpq-dev \
#        libzip-dev \
#        && docker-php-ext-install pdo pdo_mysql zip intl xmlrpc soap opcache \
#        && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd

#RUN apt-get update && apt-get install -y \
#     && docker-php-ext-install mysqli pdo pdo_mysql

#RUN apt-get install -y zip unzip build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev redis
#RUN apt-get update -y && apt-get install -y libpng-dev     

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
#    && docker-php-ext-install gd

#RUN a2enmod rewrite

#RUN apt-get update -y
# Add Node 8 LTS
#RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -- \
#	&& apt-get install -y nodejs \
#	&& apt-get autoremove -y
#COPY --from=composer /usr/bin/composer /usr/bin/composer
#ENV COMPOSER_ALLOW_SUPERUSER 1
#COPY  . /var/www/html/
#WORKDIR /var/www/html/
#RUN chown -R www-data:www-data /var/www/html  \
#    && composer install  && composer dumpautoload