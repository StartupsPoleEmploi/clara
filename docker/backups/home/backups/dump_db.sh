#!/bin/bash

date=`date +%d`

NAME=database_"$date".dump.bz2

pg_dump -Fc --no-owner --dbname=ara_production | bzip2 -cq9 | tee /home/backups/$NAME /mnt/backups/$NAME