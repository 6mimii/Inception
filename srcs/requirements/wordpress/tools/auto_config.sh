#!/bin/bash
set -e

cd /var/www/html

for attempt in {1..30}; do
    if MYSQL_PWD="$SQL_PASSWORD" mariadb --connect-timeout=2 -h mariadb -u "$SQL_USER" "$SQL_DATABASE" -e 'SELECT 1' >/dev/null 2>&1; then
        break
    fi
    if [ "$attempt" -eq 30 ]; then
        echo "MariaDB is not ready" >&2
        exit 1
    fi
    sleep 2
done

if [ ! -f "wp-load.php" ]; then
    wp core download --allow-root --force
fi
if [ ! -f "wp-config.php" ]; then
    wp config create --allow-root \
                        --dbname="$SQL_DATABASE" \
                        --dbuser="$SQL_USER" \
                        --dbpass="$SQL_PASSWORD" \
                        --dbhost=mariadb:3306 --path='/var/www/html'
fi
if ! wp core is-installed --allow-root; then
    wp core install --url="https://${DOMAIN_NAME#https://}" \
                    --title=Inception \
                    --admin_user="$SQL_USER" \
                    --admin_password="$SQL_PASSWORD" \
                    --admin_email="$SQL_USER@42.fr" \
                    --skip-email --allow-root
fi
if ! wp user get user42 --field=ID --allow-root >/dev/null 2>&1; then
    wp user create user42 user42@42.fr --role=author --user_pass="${WP_USER_PASSWORD:?Set WP_USER_PASSWORD in srcs/.env}" --allow-root
fi

mkdir -p /run/php
exec /usr/sbin/php-fpm8.2 -F
