#!/bin/bash

function ft_client ()
{
    echo "curl $1 http://127.0.0.1:2375/$2"
    curl $1 http://127.0.0.1:2375/$2 | python3 -m json.tool
}

prompt=("Flags: " "endpoint: ")

if [[ "$1" = "set" ]]; then
    echo "READ THE COMMENTS!"
    #DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 DEPRECATED
    #DOCKER_OPTS="-H tcp://127.0.0.1:2375
elif [[ "$1" = "restart" ]]; then
    service docker restart
elif [[ "$1" = "client" ]]; then
    docker -H tcp://127.0.0.1:2375 images
elif [[ "$1" = "config" ]]; then
    sudo systemctl edit docker.service
    if [[ "$2" = "reload" ]]; then
        sudo systemctl daemon-reload
        sudo systemctl restart docker.service
    fi
elif [[ "$1" = "check" ]]; then
    sudo netstat -lntp | grep dockerd
elif [[ "$1" = "API" ]]; then
    echo "Enter endpoint."
    in=()
    for i in {0..1}; do
        echo -n ${prompt[$i]}
        read
        in[$i]=$REPLY
    done
    ft_client ${in[0]} ${in[1]}  
else
    echo "Error: Wrong arguments"
    echo "  set"
    echo "  restart"
    echo "  client"
    echo "  config"
fi
