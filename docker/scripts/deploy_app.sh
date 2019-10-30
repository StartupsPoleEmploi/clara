#!/bin/bash

docker exec -w /var/git/ara.git clara_app rm -rf /var/www/ara/shared/tmp/
docker exec -w /var/git/ara.git clara_app bundle install
docker exec -w /var/git/ara.git clara_app bundle exec mina production2 setup 
docker exec -w /var/git/ara.git clara_app bundle exec mina production2 deploy 
