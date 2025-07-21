# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dcastor <dcastor@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/21 10:04:02 by dcastor           #+#    #+#              #
#    Updated: 2025/07/21 15:32:34 by dcastor          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml

up: crt
	docker compose -f srcs/docker-compose.yml up -d --build

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

.PHONY: up crt
