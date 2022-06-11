#!/bin/bash

if [[ "$1" = "run" ]]; then
    docker run -it -v ${PWD}/src/:/tmp pycurl_env /bin/bash
elif [[ "$1" = "build" ]]; then
    docker build . -t pycurl_env
fi
