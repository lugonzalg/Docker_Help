docker_id=$(docker images | grep 14.04 | awk '{ print $3 }')
echo "id: $docker_id"

if [ "$1" = "build" ]
then
    docker build -t cookbook:hello .
elif [ "$1" = "pull" ]
then
    docker pull ubuntu:14.04
elif [ "$1" = "show" ]
then
    docker images | grep $2
elif [ "$1" = "tag" ]
then
    docker tag $docker_id barfoo
elif [ "$1" = "cookbook" ]
then
    docker tag $docker_id barfoo:cookbook
fi
