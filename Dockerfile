FROM php:7.0.4-apache
RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis \
&& sed -i 's#DocumentRoot /var/www/html#DocumentRoot /vagrant/web/kaoyayacn#' /etc/apache2/apache2.conf \
&& sed -i 's#<Directory /var/www/>#<Directory /vagrant/web/kaoyayacn/>#' /etc/apache2/apache2.conf
COPY . /vagrant/web/kaoyayacn
CMD bash /vagrant/web/kaoyayacn/start.sh
