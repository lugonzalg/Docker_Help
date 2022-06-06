#!/bin/bash

if [[ "$1" = "run" ]]; then
	docker run -d --name database -e MYSQL_ROOT_PASSWORD=root mysql
	docker run -d -p 5000:5000 --link database:db --name web flask:latest
	docker run -d --link web:application --name lb nginx
elif [[ "$1" = "inspect" ]]; then
	docker inspect -f "{{.HostConfig.Links}}" lb
	docker inspect -f "{{.HostConfig.Links}}" web
fi
