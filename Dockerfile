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
&& sed -i 's#<Directory /var/www/>#<Directory /website/htdocs/kaoyayacn/>#' /etc/apache2/apache2.conf \
&& sed -i 's#DocumentRoot /var/www/html#DocumentRoot /website/htdocs/kaoyayacn/current#' /etc/apache2/apache2.conf \
&& usermod -u 1000 www-data \
&& groupmod -g 1000 www-data
COPY config/php.ini /usr/local/etc/php/
COPY ./start.sh .
CMD bash ./start.sh
