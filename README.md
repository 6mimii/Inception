*This project has been created as part of the 42 curriculum by mdoudi-b.*

# Inception

## Description

Inception runs WordPress in a virtual machine using Docker Compose. NGINX is the HTTPS entry point on port 443, WordPress runs with PHP-FPM, and MariaDB stores its database. The Makefile builds the three project images from the Dockerfiles under `srcs/requirements/`. Compose defines their shared bridge network and two named volumes. NGINX and PHP-FPM share the WordPress files, while MariaDB has its own volume.

- A VM boots its own kernel and operating system. Docker containers isolate processes while sharing the VM's kernel.
- Environment variables provide runtime configuration. Docker secrets give selected services access to confidential data as files. This project keeps its environment file local and excluded from Git.
- A Docker bridge network gives services internal addresses and name resolution. Host networking shares the host network stack.
- Docker manages named volumes. A direct bind mount maps a host path into a container. Here the named volumes use the local driver to place their data at explicit host paths.

## Instructions

Use a VM with Docker Engine, Docker Compose v2 and GNU Make. Follow [DEV_DOC.md](DEV_DOC.md) to prepare the local environment and resolve `mdoudi-b.42.fr` to the VM. Run `make` from the project root and open <https://mdoudi-b.42.fr/>. See [USER_DOC.md](USER_DOC.md) for daily operation.

## Resources

- [Docker Compose documentation](https://docs.docker.com/compose/)
- [Docker volumes](https://docs.docker.com/engine/storage/volumes/)
- [NGINX HTTPS configuration](https://nginx.org/en/docs/http/configuring_https_servers.html)
- [WP-CLI command reference](https://developer.wordpress.org/cli/commands/)

AI compared the recovered copy with the subject and evaluation sheet, helped correct Docker and the service startup scripts, drafted the required documentation and checked configuration statically.
