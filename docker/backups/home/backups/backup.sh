#!/bin/bash

date=`date +%d`

ENV_NAME=production

DUMP_NAME="${ENV_NAME}_database_$date.dump.bz2"
WWW_NAME="${ENV_NAME}_www_$date.bz2"
DOCKER_NAME="${ENV_NAME}_docker_$date.tar.bz2"

DATABASE_NAME=ara_production

pg_dump postgres://backup@srv_db:5432/$DATABASE_NAME | bzip2 -cq9 | tee /home/backups/$ENV_NAME/$DUMP_NAME /mnt/backups/$ENV_NAME/$DUMP_NAME >/dev/null

#scp -r srv_app /home/clara | bzip2 -cq9 | tee /home/backups/$ENV_NAME/$WWW_NAME /mnt/backups/$ENV_NAME/$WWW_NAME

tar --exclude=*.bz2 --exclude=*.log -jcPf - /home/docker | tee /home/backups/$DOCKER_NAME /mnt/backups/$DOCKER_NAME >/dev/null

