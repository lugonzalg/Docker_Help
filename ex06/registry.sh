#src = https://stackoverflow.com/questions/2853803/how-to-echo-shell-commands-as-they-are-executed

set -x

#exe() { echo "\$ $@" ; "$@" ; }
#exe() { "$@" ; }

if [ "$1" = "create" ]
then
    docker pull registry:2
    docker run -d -p 5000:5000 registry:2
    curl -i http://localhost:5000/v2/
elif [ "$1" = "test" ]
then
    docker images
else
    if [ -z $1 ]
    then
        echo "Error: No parameters"
    else
        echo "Error: Wrong parameter"
        echo 
    fi
fi
