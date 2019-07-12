#!/bin/bash

docker exec clara_db pg_restore --verbose --clean -x -h localhost -S ara -d ara_production  /home/dumped/latest.dump
