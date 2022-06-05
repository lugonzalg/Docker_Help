#!/bin/bash

if [[ "$1" = "run" ]]; then
	docker run -d --name nginx nginx	
	docker inspect --format '{{ .NetworkSettings.IPAddress }}' nginx
elif [[ "$1" = "ip" ]]; then
	echo ip
	docker exec -ti nginx cat /etc/hosts | tail -1 | awk '{ print $1 }'
elif [[ "$1" = "run-host" ]]; then
	docker run -d --name foobar -h foobar busybox sleep 360
	docker exec -ti foobar cat /etc/hosts | grep foobar
fi
