FROM debian:bookworm

RUN apt update && apt install -y \
	wget \
	php-fpm \
	php-mysql \
	mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copiar nuestra configuración de PHP-FPM
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Copiar el script de inicio
COPY tools/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

# Directorio de trabajo
WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
