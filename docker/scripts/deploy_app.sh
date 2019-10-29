#!/bin/bash

docker-compose exec -w /var/git/ara.git srv_app rm -rf /var/www/ara/shared/tmp/
docker-compose exec -w /var/git/ara.git srv_app bundle exec mina production2 setup 
docker-compose exec -w /var/git/ara.git srv_app bundle exec mina production2 deploy 
