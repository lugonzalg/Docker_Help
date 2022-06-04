if [ "$1" = "build" ]
then
    docker build -t cookbook:hello .
elif [ "$1" = "show" ]
then
    docker images | sed -n '2p'
elif [ "$1" = "run" ]
then
    docker_id=$(docker images | sed -n '2p' | awk '{ print $3 }')
    echo "id: $docker_id"
    docker run $docker_id $2
fi
