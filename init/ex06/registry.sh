#!/bin/bash
#src = https://stackoverflow.com/questions/2853803/how-to-echo-shell-commands-as-they-are-executed

address=$(ifconfig | grep -A1 docker0 | grep inet | awk '$1=$1')
ip=http://$(echo "$address" | awk '{ print $2 }'):5000/v2/

if [[ "$1" = "create" ]]; then
	docker pull registry:2
	docker run -d -p 5000:5000 registry:2
	curl -i http://localhost:5000/v2/
elif [[ "$1" = "tag-remote" ]]; then
	docker tag foobar localhost:5000/foobar
elif [[ "$1" = "raise" ]]; then
	docker run -d -p 5000:5000 registry:2
elif [[ "$1" = ip ]]; then
	echo $ip
elif [[ "$1" = ping ]]; then
	echo $ip
	curl -i $ip
elif [[ "$1" = "catalog" ]]; then
	curl -i "$ip"_catalog
elif [[ "$1" = "manifest" ]]; then
	curl -i "$ip"foobar/manifests/latest
elif [[ "$1" = "tag-list" ]]; then
	curl -i "$ip"foobar/tags/list
elif [[ "$1" = "push" ]]; then
	docker push localhost:5000/foobar
else
    if [ -z $1 ]; then
        echo "Error: No parameters"
    else
        echo "Error: Wrong parameter"
        echo 
    fi
fi
