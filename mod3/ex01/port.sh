#!/bin/bash

ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' flask)

if [[ "$1" = "run" ]];then
	docker run -d -p 5000/tcp -p 53/udp --rm --name flask flask
	docker ps
elif [[ "$1" = "build" ]]; then
	docker build -t flask .
elif [[ "$1" = "launch" ]]; then
	ip=$(ifconfig | grep -A1 docker0 | grep inet | /usr/bin/firefox --new-window $(awk '{ print $2 }'):49154/hi)
elif [[ "$1" = "curl" ]]; then
	echo $ip
	curl http://$ip:5000/hi
elif [[ "$1" = "port" ]]; then
	docker port flask 5000
elif [[ "$1" = "host" ]]; then
	#host=$(ifconfig | grep -A1 docker0 | grep inet | awk '{ print $2 }')
	curl "$ip":49156/hi
elif [[ "$1" = "kill" ]]; then
	docker kill flask
elif [[ "$1" = "table" ]]; then
	sudo iptables -L
fi
