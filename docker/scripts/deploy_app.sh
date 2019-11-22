#!/bin/bash
docker exec -w /var/git/ara.git clara_app git pull origin master
docker exec -w /var/git/ara.git clara_app bundle install
docker exec -w /var/git/ara.git clara_app export RUBYOPT="-KU -E utf-8:utf-8"
docker exec -w /var/git/ara.git clara_app bundle exec mina production2 setup 
docker exec -w /var/git/ara.git clara_app bundle exec mina production2 deploy 
