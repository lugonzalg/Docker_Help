#!/bin/bash

function get()
{
    echo GET
    echo $1
    curl -s http://127.0.0.1:2375/$1 | python3 -m json.tool
}

function post()
{
    echo POST
    for elem in $@; do
        echo "ELEMENT: $elem"
    done
    #CREATE AN IMAGE
    #curl -X POST -d "fromImage=ubuntu" -d "tag=14.04" http://127.0.0.1:2375/$1 | python3 -m json.tool
    #CREATE A CONTAINER
    curl -X POST -H 'Content-Type: application/json' -d '{"Image":"ubuntu:14.04"}' http://127.0.0.1:2375/$1 | python3 -m json.tool
    #-X --request
}

function delete()
{
    echo "In ft: $1"
    del=$(docker ps -a | grep minutes | awk '{ print $1 }')
    for elem in $del; do
        echo "ELEMENT: $elem"
        curl -X DELETE http://127.0.0.1:2375/$1/$elem
    done
    #echo DELETE
    #curl -X DELETE http://127.0.0.1:2375/$1/
}
while getopts "g:p:f:d:" FLAG; do
    case "${FLAG}" in
    g)
        echo GET ${OPTARG}
        get ${OPTARG}
        ;;
    p)
        echo POST ${OPTARG}
        post ${OPTARG}
        ;;
    d)
        echo DELETE ${OPTARG}
        delete ${OPTARG}
        ;;
    *)
        echo Error: Wrong argument
        ;;
    esac
done
