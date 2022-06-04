if [ "$1" = "build" ]
then
    docker build .
elif [ "$1" = "run" ]
then
    docker_id=$(docker images | sed -n '2p' | awk '{ print $3 }')
    echo "id: $docker_id"
    docker run $docker_id "hey from bash D:"
fi
