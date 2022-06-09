#!/bin/bash

if [[ "$1" = "run" ]];then
	docker run -d -P flask --name flask
	docker ps
elif [[ "$1" = "build" ]]; then
	docker build -t flask .
elif [[ "$1" = "launch" ]]; then
	ip=$(ifconfig | grep -A1 docker0 | grep inet | /usr/bin/firefox --new-window $(awk '{ print $2 }'):49154/hi)
fi
