# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dcastor <dcastor@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/21 10:04:02 by dcastor           #+#    #+#              #
#    Updated: 2025/07/24 10:53:06 by dcastor          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml

up: crt volumes setup-hosts
	docker compose -f srcs/docker-compose.yml up -d --build
	
up-force: crt volumes setup-hosts
	docker compose -f srcs/docker-compose.yml up -d --build --force-recreate

crt:
	@mkdir -p srcs/nginx/certs
	@if [ -f srcs/nginx/certs/nginx.crt ] && [ -f srcs/nginx/certs/nginx.key ]; then \
		echo "✔️  Certificate and key already exist."; \
	else \
		echo "🔐 Generating self-signed certificate..."; \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout srcs/nginx/certs/nginx.key -out srcs/nginx/certs/nginx.crt \
		-subj "/C=FR/ST=France/L=Paris/O=42/Inception/CN=dcastor.42.fr"; \
	fi

volumes:
	@mkdir -p ~/data/mariadb
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/vitrine

HOSTS_FILE=/etc/hosts
HOSTS_ENTRIES=\
"127.0.0.1   dcastor.42.fr" \
"127.0.0.1   adminer.dcastor.42.fr" \
"127.0.0.1   vitrine.dcastor.42.fr" \
"127.0.0.1   code.dcastor.42.fr"

setup-hosts:
	@echo "[INFO] Configuration des entrées /etc/hosts..."
	@for entry in $(HOSTS_ENTRIES); do \
		if ! grep -q "$$entry" $(HOSTS_FILE); then \
			echo "$$entry" | sudo tee -a $(HOSTS_FILE) > /dev/null; \
			echo "[OK] Ajouté: $$entry"; \
		else \
			echo "[SKIP] Déjà présent: $$entry"; \
		fi \
	done

clean:
	@docker stop $(docker ps -qa)
	@docker rm $(docker ps -qa) 
	@docker rmi -f $(docker images -qa) 
	@docker volume rm $(docker volume ls -q)

.PHONY: up crt volumes up-force setup-hosts
