#!/bin/bash

date=`date +%d`

NAME=www_"$date".bz2

ENV_NAME=`docker exec srv_app printenv ARA_DATABASE_NAME`

scp -r srv_app /home/clara | bzip2 -cq9 | tee /home/backups/$ENV_NAME/$NAME /mnt/backups/$ENV_NAME/$NAME
