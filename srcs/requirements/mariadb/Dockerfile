FROM debian:bookworm

RUN apt update && apt install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mdb-conf.sh /usr/local/bin/mdb-conf.sh

RUN chmod +x /usr/local/bin/mdb-conf.sh

# Crear carpeta necesaria para el socket
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

ENTRYPOINT ["/usr/local/bin/mdb-conf.sh"]
