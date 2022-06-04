#!/bin/bash

if [[ "$1" = login ]]; then
	docker login -u $DOCKER_LOGIN -p $DOCKER_PASS
elif [[ "$1" = "build" ]]; then
	docker build . -t foobar:latest
elif [[ "$1" = "push" ]]; then
	docker push lugonzalg/foobar
elif [[ "$1" = logout ]]; then
	docker logout
elif [[ "$1" = tag ]]; then
	docker tag foobar lugonzalg/foobar
fi
