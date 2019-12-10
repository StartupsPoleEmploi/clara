#!/bin/bash

date=`date +%d`

NAME=database_"$date".dump.bz2

DATABASE_NAME=`docker exec srv_app printenv ARA_DATABASE_NAME`

pg_dump postgres://backup@srv_db:5432/$DATABASE_NAME | bzip2 -cq9 | tee /home/backups/$DATABASE_NAME/$NAME /mnt/backups/$DATABASE_NAME/$NAME
