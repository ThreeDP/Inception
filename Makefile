COMPOSE = srcs/docker-compose.yml
IMAGES = $(docker ps -qa)

all: build up

build:
	sudo chmod a+w /etc/hosts
	sudo cat /etc/hosts | grep dapaulin.42.fr || echo "127.0.0.1 dapaulin.42.fr"
	sudo mkdir -p /home/dapaulin/data/mariadb
	sudo mkdir -p /home/dapaulin/data/wordpress
	docker-compose -f $(COMPOSE) build

up:
	docker-compose -f $(COMPOSE) up -d

down:
	docker-compose -f $(COMPOSE) down -d

clean:
	docker-compose -f $(COMPOSE) down --rmi all

fclean:
	docker stop $(docker ps -qa); \
	docker rm $(docker ps -qa); \
	docker rmi -f $(docker images -qa); \
	docker volume rm $(docker volume ls -q); \
	docker network rm $(docker network ls -q) 2>/dev/null; 

.PHONY: all build up down fclean
