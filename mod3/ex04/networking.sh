#!/bin/bash

if [[ "$1" = "run-nohost" ]]; then
	docker run -it --rm --net=none ubuntu:14.04 bash
	#-> in the docker >ip -d link show
	#route
elif [[ "$1" = "run-host" ]]; then
	docker run -it --rm --net=host ubuntu:14.04 bash
	#-> ip -d link show
elif [[ "$1" = "raise-hostname" ]]; then
	docker run -d -it --rm -h cookbook ubuntu:14.04 bash
elif [[ "$1" = "run-container" ]]; then
	docker run -ti --rm --net=container:zen_agnesi ubuntu:14.04 bash
	#-> ifconfig
fi
