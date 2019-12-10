#!/bin/bash

date=`date +%d`

DUMP_NAME=database_"$date".dump.bz2
WWW_NAME=www_"$date".bz2

#DATABASE_NAME=`docker exec srv_app printenv ARA_DATABASE_NAME`
DATABASE_NAME=production


pg_dump postgres://backup@srv_db:5432/$DATABASE_NAME | bzip2 -cq9 | tee /home/backups/$DATABASE_NAME/$DUMP_NAME /mnt/backups/$DATABASE_NAME/$DUMP_NAME
scp -r srv_app /home/clara | bzip2 -cq9 | tee /home/backups/$ENV_NAME/$WWW_NAME /mnt/backups/$ENV_NAME/$WWW_NAME
