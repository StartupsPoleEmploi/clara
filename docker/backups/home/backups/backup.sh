#!/bin/bash

date=`date +%d`

DUMP_NAME=database_"$date".dump.bz2
WWW_NAME=www_"$date".bz2

DATABASE_NAME=ara_production
ENV_NAME=production


pg_dump postgres://backup@srv_db:5432/$DATABASE_NAME | bzip2 -cq9 | tee /home/backups/$ENV_NAME/$DUMP_NAME /mnt/backups/$ENV_NAME/$DUMP_NAME
scp -r clara_rails /home/clara | bzip2 -cq9 | tee /home/backups/$ENV_NAME/$WWW_NAME /mnt/backups/$ENV_NAME/$WWW_NAME
