FROM php:7.0.4-apache
RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  apt-get update && apt-get install -y \
libmcrypt-dev \
zlib1g-dev \
libfreetype6-dev \
libjpeg62-turbo-dev \
libpng12-dev \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install  iconv mbstring mcrypt pdo_mysql mysqli sockets zip gd \
&& docker-php-ext-enable redis \
&& usermod -u 1000 www-data \
&& groupmod -g 1000 www-data
COPY config/php/php.ini /usr/local/etc/php/
COPY config/apache/apache.conf /etc/apache2/conf-enabled/
COPY ./start.sh .
CMD bash ./start.sh
