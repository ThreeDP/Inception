COMPOSE = srcs/docker-compose.yml
IMAGES = $(docker ps -qa)

all: build up

build:
	sudo chmod a+w /etc/hosts
	sudo cat /etc/hosts | grep dapaulin.42.fr || echo "127.0.0.1 dapaulin.42.fr" >> /etc/hosts
	sudo mkdir -p /home/dapaulin/data/mariadb
	sudo mkdir -p /home/dapaulin/data/wordpress
	docker-compose -f $(COMPOSE) build

up:
	docker-compose -f $(COMPOSE) up -d

down:
	docker-compose -f $(COMPOSE) down

clean:
	docker-compose -f $(COMPOSE) down --rmi all

fclean: clean
	sudo rm -rf /home/dapaulin/data/mariadb
	sudo rm -rf /home/dapaulin/data/wordpress
	docker system prune --all -f

.PHONY: all build up down fclean
