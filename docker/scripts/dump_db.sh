date=`date +%F`
pg_dump -Fc --no-owner --dbname=ara_production > /mnt/backups/"$date".dump