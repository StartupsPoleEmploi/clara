#!/bin/bash

docker exec clara_db pg_restore --verbose --clean -x -h localhost -S ara -d ara_test  /home/dumped/latest.dump
