# Developer documentation

## Setup

Use a VM with Docker Engine, Docker Compose v2, GNU Make, internet access for the build and initial WordPress download, and an account that can run Docker and write to `/home/mdoudi-b/data`. On the machine that opens the site, configure local DNS or the hosts file so `mdoudi-b.42.fr` resolves to the VM IP. Use the loopback address if the browser runs in the VM.

Create `srcs/.env` locally with mode 600. Set `DOMAIN_NAME` to `mdoudi-b.42.fr`, choose a database name for `SQL_DATABASE`, and choose a username for `SQL_USER`. The same name is used for the initial WordPress administrator, so use letters, digits or underscores and avoid `admin` and `user42`. Set private values for `SQL_PASSWORD`, `SQL_ROOT_PASSWORD` and `WP_USER_PASSWORD`. Use randomly generated hexadecimal passwords to avoid shell or Compose quoting issues. Keep this file out of Git.

## Build and manage

Run `make` from the root to create the storage directories, build the three images and start the stack. Use these commands from the same directory:

```sh
docker compose -f srcs/docker-compose.yml config --quiet
docker compose -f srcs/docker-compose.yml ps
docker compose -f srcs/docker-compose.yml logs --tail=30
docker compose -f srcs/docker-compose.yml exec mariadb mariadb -u root -p
docker volume ls
```

Enter the local root password at the MariaDB prompt. Use `make stop` to stop containers or `make clean` to remove the containers and network. `make fclean` also removes the Compose volumes and images. `make re` then rebuilds and starts the stack.

## Persistence

The named volumes `mariadb_data` and `wordpress_data` use the local driver with host directories `/home/mdoudi-b/data/mariadb` and `/home/mdoudi-b/data/wordpress`. Compose normally prefixes their names with the project name. Use `docker volume inspect VOLUME_NAME` to see the host directory in the driver options. The files in these directories survive container removal and VM reboot. Keep backups of both directories before migrating data from an older MariaDB version.
