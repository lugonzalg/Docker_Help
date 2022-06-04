#!/bin/bash

arr=()

function ft_show_images ()
{
	i=0
	echo "choose a image id"
	for elem in $@; do
		arr[$i]=$elem
		echo -n "[$i] "
		echo $elem
		i=$((i+1))
	done
	echo "Choose an option: "
	read $in
	return ${REPLY}
}		

function ft_create_files ()
{
	echo "This is the path of the container $1"
}

if [[ "$1" = "run" ]] || [[ "$1" = "pull" ]]; then
	if [[ "$2" = "rw" ]]; then
		echo "READ WRITE"
		docker run -ti -v "$PWD":/cookbook ubuntu:14.04 /bin/bash
	else
		echo "READ ONLY"
		docker run -ti -v "$PWD":/cookbook:ro ubuntu:14.04 /bin/bash
	fi
elif [[ "$1" = "inspect" ]]; then
	if [[ -z $2 ]]; then
		echo "inspect by fixed id"
		docker inspect -f {{.Mounts}} 58344351b4b7
	else
		echo "inspect by name"
		docker inspect -f {{.Mounts}} $2
	fi
elif [[ "$1" = "run_dk" ]] || [[ "$1" = "pull_dk" ]]; then
	docker run -ti -v /cookbook ubuntu:14.04 /bin/bash
elif [[ "$1" = "show_volumes" ]]; then
	if [[ -z $2 ]]
	then
		echo "outer"
		list=$(sudo ls -la /var/lib/docker/volumes | tail -n +4 | awk '{print $9}')
		ft_show_images $list
		container_path=/var/lib/docker/volumes/$(echo "${arr[$?]}")
		sudo ls -lah $container_path
		ft_create_files $container_path
	else
		echo "inner"
		sudo ls -lah /var/lib/docker/volumes/$2
		sudo ls -lah /var/lib/docker/volumes/$2/_data
	fi
elif [[ "$1" = "raise" ]]; then
	if [[ "$2" = "shared" ]]; then
		docker run -ti --volumes-from $3 --name receiver ubuntu:14.04 /bin/bash
	else
		docker run -v /data --name $2 ubuntu:14.04
	fi
	#echo "The docker id is $docker_id"
elif [[ "$1" = "help" ]]; then
	echo 'Commands:'
	echo "	pull"
	echo "	run"
	echo "	inspect"
	echo "	run_dk"
	echo "	pull_dk"
	echo "	show_volumes"
	echo "	raise"
fi
