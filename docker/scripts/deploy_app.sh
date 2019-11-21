#!/bin/bash
docker-compose exec -w cd /var/git/ara.git srv_app git pull origin master
docker-compose exec -w cd /var/git/ara.git srv_app bundle install
docker-compose exec -w cd /var/git/ara.git srv_app export RUBYOPT="-KU -E utf-8:utf-8"
docker-compose exec -w cd /var/git/ara.git srv_app bundle exec mina production2 setup 
docker-compose exec -w cd /var/git/ara.git srv_app bundle exec mina production2 deploy 
