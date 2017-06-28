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
&& printf 'session.save_handler = redis \nsession.save_path = "tcp://1b24b55fcaed40cb.m.cnqda.kvstore.aliyuncs.com:6379?auth=1b24b55fcaed40cb:feng6KVS8kyyfor&database=2"\n' >> /usr/local/etc/php/conf.d/docker-php-ext-redis.ini \
&& printf 'error_reporting = E_ERROR & ~E_DEPRECATED & ~E_STRICT \noutput_buffering=4096 \n' >> /usr/local/etc/php/php.ini \
&& sed -i 's#<Directory /var/www/>#<Directory /website/htdocs/kaoyayacn/>#' /etc/apache2/apache2.conf \
&& sed -i 's#DocumentRoot /var/www/html#DocumentRoot /website/htdocs/kaoyayacn/current#' /etc/apache2/apache2.conf \
&& usermod -u 1000 www-data \
&& groupmod -g 1000 www-data
COPY . .
CMD bash ./start.sh
