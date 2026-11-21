#!/bin/bash
set -e

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

umask 077
cat > /run/mysqld/inception.sql <<SQL
SET SESSION sql_mode = 'NO_BACKSLASH_ESCAPES';
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE//\`/\`\`}\`;
CREATE USER IF NOT EXISTS '${SQL_USER//\'/\'\'}'@'%' IDENTIFIED BY '${SQL_PASSWORD//\'/\'\'}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE//\`/\`\`}\`.* TO '${SQL_USER//\'/\'\'}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD//\'/\'\'}';
SQL
chown mysql:mysql /run/mysqld/inception.sql
umask 022
exec mariadbd --user=mysql --init-file=/run/mysqld/inception.sql
