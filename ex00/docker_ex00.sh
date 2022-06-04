
#-z no argument
#-n argument?

if [ "$1" = "run" ]
then
    docker run -d -p 1234:1234 python:2.7 python -m SimpleHTTPServer 1234
elif [ "$1" = "interact" ]
then
    docker_id=$(docker ps | grep Simple | awk '{ print $1 }' | tr -d '\n')
    echo "The docker id is $docker_id"
    docker exec -ti $docker_id /bin/bash
elif [ "$1" = "list" ]
then
    docker ps | head -1 | awk '{ print $3 }'
    docker ps | tail -n +2 | awk '{ print $2 }'
elif [ "$1" = "status" ]
then
    docker ps
elif [ "$1" = "show" ]
then
    ifconfig | grep -A1 docker0 | grep inet | /usr/bin/firefox --new-window $(awk '{ print $2 }'):1234
else
    if [ -z "$1" ]
    then
        echo "Error: No argument"
    else
        echo "Error: Wrong argument $1"
        echo "Arguments:\n\trun\n\tinteract\n\tlist\n\tshow"
    fi
fi
