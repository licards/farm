FROM php:7.1-apache

ARG PHP_SOCKET=php-fpm:9000

ENV WEB_PHP_SOCKET=$PHP_SOCKET
ENV WEB_DOCUMENT_ROOT=/var/www/

EXPOSE 80 443
WORKDIR /var/www/html/

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    vim \
    curl \
    wget \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng12-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mcrypt \
  && docker-php-ext-install pdo_mysql

RUN pecl install xdebug && \
  docker-php-ext-enable xdebug

# configuring apache
RUN echo "ServerName localhost" >> /etc/apache2/conf-available/docker-php.conf

# adding vhost
ADD ./vhost.conf /etc/apache2/sites-available/api.licards.conf

RUN a2ensite api.licards
RUN a2enmod rewrite

# restarting apache
RUN service apache2 start

# install composer
RUN curl -sS https://getcomposer.org/installer | php

# www-data user permission
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data
