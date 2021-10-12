FROM php:7.4-fpm-alpine3.14

RUN \
    apk add --update --no-cache \
        bash \
        bash-completion \
        curl \
        openssl \
        git \
        make \
        vim \
        nano \
        gnupg \
        unzip \
        wget \
        zlib-dev \
        libzip-dev \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install zip pdo_mysql opcache

# Setting up PHP
ARG ENV
COPY "docker/php/${ENV}/config/opcache.ini" /usr/local/etc/php/conf.d/opcache.ini
ARG TZ
RUN echo "date.timezone = ${TZ}" > /usr/local/etc/php/conf.d/timezone.ini

# Install composer
RUN \
    curl -sl https://getcomposer.org/composer-2.phar -o /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer;

# Download & Install Symfony binary
ARG SYMFONY_VERSION
RUN \
    if [ "none" != ${SYMFONY_VERSION} ]; then \
        wget https://get.symfony.com/cli/installer -O - | bash; \
        mv /root/.symfony/bin/symfony /usr/local/bin/symfony; \
    fi

ARG UID
RUN \
    apk add --no-cache --virtual .build-deps shadow; \
    mkdir -p /var/www/html; \
    adduser -D -s /bin/bash -u ${UID} docker; \
    chown -R docker /var/www/html; \
    apk del --no-network .build-deps;

COPY docker/php/.bashrc /home/docker/.bashrc

USER docker

WORKDIR /var/www/html

# Setting up git
RUN \
    git config --global user.email "php@docker.com"; \
    git config --global user.name "PHP Docker";
