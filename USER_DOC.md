# User documentation

NGINX serves the site over HTTPS, PHP-FPM runs WordPress, and MariaDB stores its data.

From the project root, run `make` to build and start the stack, `make stop` to stop it, or `make up` to start it again. Open <https://mdoudi-b.42.fr/> for the site and <https://mdoudi-b.42.fr/wp-admin/>, accepting the VM's self-signed certificate for this local setup.

The initial administrator uses `SQL_USER` and `SQL_PASSWORD` from the private `srcs/.env`. The initial password for `user42` is set by `WP_USER_PASSWORD`. Use the WordPress profile or Users screen to change WordPress passwords after installation. Existing accounts retain their current WordPress passwords across restarts.

Run `docker compose -f srcs/docker-compose.yml ps` and check that all three services are running and only NGINX publishes port 443. Visit the home page and sign in to the dashboard to confirm WordPress is installed and connected to MariaDB.
