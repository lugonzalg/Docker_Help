#!/bin/bash

if [[ "$1" = "run" ]]; then
	docker run -d --name database -e MYSQL_ROOT_PASSWORD=root mysql
	docker run -d --link database:db --name web runseb/hostname
	docker run -d --link web:application --name lb nginx
fi
