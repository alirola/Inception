name = Inception
all:
	@printf "Configuring ${name}...\\n"
	@if [ ! -d "/home/alirola/data/" ]; then \
		mkdir -p /home/alirola/data/; \
	fi
	@if [ ! -d "/home/alirola/data/mariadb" ]; then \
		mkdir -p /home/alirola/data/mariadb; \
	fi
	@if [ ! -d "/home/alirola/data/wordpress" ]; then \
		mkdir -p /home/alirola/data/wordpress; \
	fi
	@docker-compose -f ./srcs/docker-compose.yml --env-file /home/alirola/.env up -d

build:
	@printf "Building ${name} configuration...\\n"
	@if [ ! -d "/home/alirola/data/" ]; then \
		mkdir -p /home/alirola/data/; \
	fi
	@if [ ! -d "/home/alirola/data/mariadb" ]; then \
		mkdir -p /home/alirola/data/mariadb; \
	fi
	@if [ ! -d "/home/alirola/data/wordpress" ]; then \
		mkdir -p /home/alirola/data/wordpress; \
	fi
	@docker-compose -f ./srcs/docker-compose.yml --env-file /home/alirola/.env up -d --build

down:
	@printf "Stopping ${name}...\\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file /home/alirola/.env down

re: down
	@printf "Rebuilding ${name}...\\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file /home/alirola/.env up -d --build
	@if [ ! -d "/home/alirola/data/" ]; then \
		mkdir -p /home/alirola/data/; \
	fi
	@if [ ! -d "/home/alirola/data/mariadb" ]; then \
		mkdir -p /home/alirola/data/mariadb; \
	fi
	@if [ ! -d "/home/alirola/data/wordpress" ]; then \
		mkdir -p /home/alirola/data/wordpress; \
	fi
clean: down
	@printf "Cleaning ${name}...\\n"
	@docker system prune -a
	@sudo chmod -R 777 /home/alirola/data
	@sudo rm -rf /home/alirola/data/wordpress/*
	@sudo rm -rf /home/alirola/data/mariadb/*

fclean:
	@printf "Full cleaning ${name}...\\n"
	@sudo chmod -R 777 /home/alirola/data
	@sudo rm -rf /home/alirola/data/mariadb/*
	@sudo rm -rf /home/alirola/data/wordpress/*
	@sudo rm -rf /home/alirola/data/*
	@sudo rm -rf /home/alirola/data
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@docker volume rm $$(docker volume ls -q)

.PHONY	: all build down re clean fclean
