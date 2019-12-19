#!/bin/bash

docker exec clara_db bash -c "DB=\$ENV_TYPE; if [ \"\$DB\" = \"developpement\" ]; then DB=dev; fi;  pg_restore --verbose --clean -x -h localhost -S ara -d ara_\$DB /home/db/latest.dump"
