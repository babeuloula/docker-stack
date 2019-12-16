FROM php:7.4-fpm

RUN \
       apt-get update \
    && apt-get install -y --fix-missing \
        apt-utils \
        gnupg \
        vim \
        unzip \
        git \
        wget \
    && echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && curl -sS --insecure https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    && apt-get update \
    && apt-get install -y \
        zlib1g-dev \
        libzip-dev \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install zip pdo_mysql opcache

# Setting up PHP
ARG ENV
COPY "docker/php/${ENV}/config/opcache.ini" /usr/local/etc/php/conf.d/opcache.ini
RUN echo "date.timezone = Europe/Paris" > /usr/local/etc/php/conf.d/timezone.ini

# Install composer
RUN \
    curl -sl https://getcomposer.org/composer.phar -o /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer; \
    composer global require hirak/prestissimo;

# Download & Install Symfony binary
ARG SYMFONY_VERSION
RUN \
    if [ "none" != ${SYMFONY_VERSION} ]; then \
        wget https://get.symfony.com/cli/installer -O - | bash; \
        mv /root/.symfony/bin/symfony /usr/local/bin/symfony; \
    fi

ARG UID
RUN \
    useradd -ms /bin/bash --uid ${UID} docker; \
    usermod -a -G docker docker; \
    chown -R docker /var/www/html;

COPY docker/php/.bashrc /home/docker/.bashrc

WORKDIR /var/www/html

USER docker

# Setting up git
RUN \
    git config --global user.email "php@docker.com"; \
    git config --global user.name "PHP Docker";
