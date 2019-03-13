FROM php:7.2-fpm
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install bcmath pdo_mysql mysqli \
    && apt-get install -y \
		vim \
		curl \
		git \
		wget \
		gnupg \
    && curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
        apt-get install -y nodejs && \
        npm install -g npm
RUN curl -sL https://getcomposer.org/installer | php -- --install-dir /usr/bin --filename composer