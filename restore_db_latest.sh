#!/bin/bash

docker exec clara_db pg_restore --verbose --clean -x -h localhost -S ara -d ara_`echo $ENV_TYPE` /home/db/latest.dump
