FROM php:5.6-fpm
MAINTAINER Yingchun Han <chunchun7408@gmail.com>
RUN apt-get update && apt-get install -y nginx libpng12-dev libjpeg-dev libpq-dev php5-mcrypt libmcrypt-dev php5-gd libgd2-xpm-dev* libfreetype6-dev libjpeg62-turbo-dev cron
RUN pecl install igbinary redis swoole \
	&& docker-php-ext-enable igbinary redis swoole \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql mysql mysqli mcrypt
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
EXPOSE 80
CMD service nginx restart && docker-php-entrypoint php-fpm