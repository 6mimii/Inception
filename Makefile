# Variables
DOCKER_COMPOSE = ./srcs/docker-compose.yml
DATA_PATH = /home/mdoudi-b/data

# Regla principal (se ejecuta solo con 'make')
all: build
	$(MAKE) up

# Crear directorios y levantar contenedores
build:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	docker compose -f $(DOCKER_COMPOSE) build

up:
	docker compose -f $(DOCKER_COMPOSE) up -d

# Detener los contenedores
stop:
	docker compose -f $(DOCKER_COMPOSE) stop

# Limpieza básica (contenedores y redes)
clean:
	docker compose -f $(DOCKER_COMPOSE) down

# Limpieza TOTAL (borra hasta los datos de la base de datos)
fclean:
	docker compose -f $(DOCKER_COMPOSE) down --volumes --rmi all

re: fclean
	$(MAKE) all

.PHONY: all build up stop clean fclean re
