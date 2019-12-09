$date = date +%F
docker exec clara_db pg_dump -Fc --no-owner --dbname=ara_production > "$date".dump
