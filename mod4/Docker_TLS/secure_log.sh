#!/bin/bash

if [[ "$1" = "build" ]]; then
    docker build -t openssl .
elif [[ "$1" = "run" ]]; then
    docker run -d -v ${pwd}:/tmp/ca -ti openssl $HOSTNAME
fi
