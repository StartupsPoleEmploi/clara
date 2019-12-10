#!/bin/bash

date=`date +%d`

NAME=database_"$date".dump.bz2

pg_dump postgres://backup@srv_db:5432/ara_production | bzip2 -cq9 | tee /home/backups/$NAME /mnt/backups/$NAME
