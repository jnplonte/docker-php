FROM php:8.1.5-apache

# Install PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && apt-get install -y \
    dialog apt-utils \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libmemcached-dev \
    default-libmysqlclient-dev \
    libicu-dev \
    libpq-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    pkg-config \
  && rm -r /var/lib/apt/lists/* \
  && docker-php-ext-configure \
    pdo_mysql --with-pdo-mysql=mysqlnd \
  && docker-php-ext-install \
    mysqli \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    opcache \
  && curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/refs/tags/v3.2.0.tar.gz" \
  && mkdir -p /usr/src/php/ext/memcached \
  && tar -C /usr/src/php/ext/memcached -zxvf /tmp/memcached.tar.gz --strip 1 \
  && docker-php-ext-configure memcached \
  && docker-php-ext-install memcached \
  && rm /tmp/memcached.tar.gz \
  && mkdir -p /usr/src/php/ext/redis \
  && curl -L https://github.com/phpredis/phpredis/archive/refs/tags/5.3.7.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
  && echo 'redis' >> /usr/src/php-available-exts \
  && docker-php-ext-install redis

# install git
RUN apt-get update && apt-get install git git-core -y && apt-get clean

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# install dependencies
# RUN composer install --prefer-source --no-interaction

# Install nodejs
RUN curl -sS https://nodejs.org/dist/v16.15.0/node-v16.15.0-linux-x64.tar.xz | tar --file=- --extract --xz --directory /usr/local/ --strip-components=1

# Add Error log folder
RUN mkdir -p /var/www/errorlogs && chmod 777 -R /var/www/errorlogs

# Put apache config
COPY ./application/php.ini 	/usr/local/etc/php/custom.php.ini
COPY ./application/configuration.conf /etc/apache2/sites-available/configuration.conf

RUN a2ensite configuration.conf && a2enmod rewrite

# Add index php info for testing
COPY ./application/am5wbG9udGU.php /var/www/html/am5wbG9udGU.php
COPY ./application/ZGF0YS1iYXNl.php /var/www/html/ZGF0YS1iYXNl.php

# Change uid and gid of apache to docker user uid/gid
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

# remove unnecessary files
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
