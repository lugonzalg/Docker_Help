#!/bin/bash

ip=http://$(ifconfig | grep -A1 docker0 | grep inet | awk '{ print $2 }'):81
echo $ip

if [ "$1" = "pull"  ]
then
	docker pull wordpress:latest
	docker pull mysql:latest
elif [ "$1" = "images" ]
then
	docker images | grep -E "wordpress|mysql"
elif [ "$1" = "run_mysql" ]
then
	docker run --name mysqlwp -e MYSQL_ROOT_PASSWORD=wordpressdocker \
	-e MYSQL_DATABASE=wordpress \
	-e MYSQL_USER=wordpress \
	-e MYSQL_PASSWORD=wordpresspwd \
	-v /home/docker/mysql:/var/lib/mysql \
	-d mysql #mount a volume
elif [ "$1" = "run_wp" ]
then
	docker run --name wordpress --link mysqlwp:mysql -p 81:80 \
	-e WORDPRESS_DB_NAME=wordpress \
	-e WORDPRESS_DB_USER=wordpress \
	-e WORDPRESS_DB_PASSWORD=wordpresspwd \
	-d wordpress
elif [ "$1" = "dump" ]
then
	docker exec mysqlwp mysqldump --all-databases --password=wordpressdocker > wordpress.backup
elif [ "$1" = "ip" ]
then
	echo $ip
elif [ "$1" = "launch" ]
then
	/usr/bin/firefox --new-window $ip
else
	if [ -z "$1" ]
    	then
        	echo "Error: No argument"
    	else
		echo "Error: Wrong argument $1"
		echo "Arguments:\n\trun\n\tinteract\n\tlist\n\tshow"
	fi
fi
