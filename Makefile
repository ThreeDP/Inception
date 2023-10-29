COMPOSE = srcs/docker-compose.yml

all: build up

build:
	sudo chmod a+w /etc/hosts
	sudo cat /etc/host | grep dapaulin.42.fr || echo "127.0.0.1 dapaulin.42.fr"
	sudo mkdir -p /home/dapaulin/data/mariadb
	sudo mkdir -p /home/dapaulin/data/wordpress

up:
	docker-compose -f $(COMPOSE) up -d

down:
	docker-compose -f $(COMPOSE) down -d

fclean:
	docker-compose -f $(COMPOSE) down --rmi all


.PHONY: all build up down fclean