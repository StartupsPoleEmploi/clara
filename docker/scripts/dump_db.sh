docker exec clara_db pg_dump --verbose --clean -x -h localhost -S ara -d ara_production latest.dump
