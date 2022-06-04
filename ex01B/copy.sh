#!/bin/bash

if [[ "$1" = "run" ]]; then
	docker run -d --name testcopy ubuntu:14.04 sleep 360
	docker exec -ti testcopy /bin/bash
elif [[ "$1" = "cp" ]]; then
	if [[ "$1" = "to" ]]
		docker cp testcopy:/root/file.txt .
	else
		docker cp host.txt testcopy:/root/host.txt
	fi
elif [[ "$1" = "exec" ]]; then
	docker exec -ti testcopy /bin/bash
fi
