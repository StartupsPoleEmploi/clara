#!/bin/bash
docker exec -w /var/git/ara.git srv_app git pull origin master
docker exec -w /var/git/ara.git srv_app bundle install
docker exec -w /var/git/ara.git srv_app export RUBYOPT="-KU -E utf-8:utf-8"
docker exec -w /var/git/ara.git srv_app bundle exec mina production2 setup 
docker exec -w /var/git/ara.git srv_app bundle exec mina production2 deploy 
