#!/bin/bash

NAME=database_"$date".dump.bz2

date=`date +%F`
pg_dump -Fc --no-owner --dbname=ara_production | bzip2 -cq9 | tee /home/backups/$NAME /mnt/backups/$NAME