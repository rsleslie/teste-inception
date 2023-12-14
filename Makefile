# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/11 20:50:04 by user42            #+#    #+#              #
#    Updated: 2023/12/14 19:39:14 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.PHONY: all build up clean down fclean

DOCKER_COMPOSE = cd srcs && docker-compose

all:
	sudo sh -c 'echo "127.0.0.1    rleslie.42.fr" >> /etc/hosts'
	sudo mkdir -p /home/rleslie-/data/mariadb
	sudo mkdir -p /home/rleslie-/data/wordpress
	$(DOCKER_COMPOSE) up --build -d

DOCKER_COMPOSE = cd srcs && docker-compose

all: setup build up

build:
	$(DOCKER_COMPOSE) build

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

clean: down
	sudo rm -rf /home/rleslie-/data/wordpress
	sudo rm -rf /home/rleslie-/data/mariadb

re: clean all

setup:
	sudo sh -c 'echo "127.0.0.1    rleslie.42.fr" >> /etc/hosts'
	sudo mkdir -p /home/rleslie-/data/mariadb
	sudo mkdir -p /home/rleslie-/data/wordpress
