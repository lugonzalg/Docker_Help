if [ "$1" = "export" ]
then
    docker export $1 > export.tar
if [ "$1" = "import" ]
then
    docker import - import < export.tar
fi
