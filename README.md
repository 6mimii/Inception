# Inception

## Description

Inception is a 42 system administration project. Its goal is to deploy a WordPress website in a virtual machine using Docker Compose.

The stack runs three services on a private Docker bridge network:

- **NGINX** serves the site over HTTPS on port 443 using TLS 1.2 or TLS 1.3.
- **WordPress** runs with PHP-FPM. It connects to MariaDB over the internal network.
- **MariaDB** stores the WordPress database.

The root `Makefile` builds and starts the stack. `srcs/docker-compose.yml` defines the services, network and volumes. Each service has its own Dockerfile and configuration under `srcs/requirements/`. The images are built from Debian Bookworm.

### Design choices

- **Virtual machines vs Docker.** A VM runs its own operating system and kernel. Containers isolate processes and share the VM's kernel. This project runs all three containers inside a VM.
- **Secrets vs environment variables.** Environment variables pass configuration to processes. Docker secrets make confidential values available as files to selected services. This project uses a private `srcs/.env` file excluded from Git.
- **Docker network vs host network.** A bridge network lets the containers reach each other by service name. Host networking shares the host network stack. Here, only NGINX publishes a port to the host.
- **Docker volumes vs bind mounts.** Named volumes are managed by Docker. Bind mounts map host paths into containers. This project uses two named volumes with the `local` driver and the `o: bind` option to store the database and website files under `/home/mdoudi-b/data`.

## Instructions

Use a VM with Docker Engine, Docker Compose v2 and GNU Make. Your account needs access to Docker and permission to create directories under `/home/mdoudi-b/data`.

1. Follow [DEV_DOC.md](DEV_DOC.md) to create your private `srcs/.env` and configure `mdoudi-b.42.fr` to resolve to your VM.
2. Run the following commands from the repository root:

   ```sh
   make
   docker compose -f srcs/docker-compose.yml ps
   ```

3. Open <https://mdoudi-b.42.fr/>. The project uses a self-signed certificate, so your browser may show a certificate warning. The WordPress dashboard is at <https://mdoudi-b.42.fr/wp-admin/>.

Use `make stop` to stop the services, `make up` to start them again, or `make clean` to remove the containers and network. See [USER_DOC.md](USER_DOC.md) for account management and basic checks.

## Resources

- [Docker Compose documentation](https://docs.docker.com/compose/)
- [Docker volumes documentation](https://docs.docker.com/engine/storage/volumes/)
- [NGINX HTTPS configuration](https://nginx.org/en/docs/http/configuring_https_servers.html)
- [WP-CLI command reference](https://developer.wordpress.org/cli/commands/)

AI was used to review the recovered project against the subject and evaluation sheet, help update the Docker configuration and startup scripts, draft the documentation, and test a clean installation in an isolated Docker environment.
