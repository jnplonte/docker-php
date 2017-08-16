FROM php:7.0-apache

MAINTAINER John Paul Onte <jnpl.onte@gmail.com>

# Install PHP extensions
RUN apt-get update && apt-get install -y \
      libicu-dev \
      libpq-dev \
      libmcrypt-dev \
      libcurl4-openssl-dev \
      libmemcached-dev \
      curl \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install \
      mysqli \
      intl \
      mbstring \
      mcrypt \
      pcntl \
      curl \
      pdo_mysql \
      pdo_pgsql \
      memcached \
      redis \
      zip \
      opcache

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install nodes
RUN curl https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.xz | tar --file=- --extract --xz --directory /usr/local/ --strip-components=1

# Add Error log folder
RUN mkdir -p /var/www/errorlogs && chmod 777 -R /var/www/errorlogs

# Put apache config
COPY ./application/configuration.conf /etc/apache2/sites-available/configuration.conf
RUN a2ensite configuration.conf && a2enmod rewrite

# Add index php info for testing
COPY ./application/am5wbG9udGU.php /var/www/html/am5wbG9udGU.php

# Change uid and gid of apache to docker user uid/gid
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

WORKDIR /var/www/html
