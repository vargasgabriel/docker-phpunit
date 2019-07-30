# PHPUnit Docker Container.
FROM composer/composer
MAINTAINER Julien Breux <julien.breux@gmail.com>

COPY docker-php-pecl-install /usr/local/bin/

# Run some Debian packages installation.
ENV PACKAGES="php-pear curl"
RUN apt-get update && \
    apt-get install -yq --no-install-recommends $PACKAGES && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Run xdebug installation.
RUN docker-php-pecl-install xdebug-2.3.3 uploadprogress-1.0.3.1 && \
    docker-php-ext-install pcntl && \
    php -m

# Goto temporary directory.
WORKDIR /tmp

# Run composer and phpunit installation.
RUN composer selfupdate && \
    composer require "phpunit/phpunit:~4.8.16" --prefer-source --no-interaction && \
    ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

# Set up the application directory.
VOLUME ["/app"]
WORKDIR /app

# Set up the command arguments.
ENTRYPOINT ["/usr/local/bin/phpunit"]
CMD ["--help"]
