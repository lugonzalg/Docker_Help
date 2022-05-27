if [ "$1" = "run" ]
then
    docker run -t -i ubuntu:14.04 /bin/bash
elif [ "$1" = "commit"  ]
then
    docker commit $2 ubuntu:update
elif [ "$1" = "check" ]
then
    docker run ubuntu:update -ti /bin/bash
fi
