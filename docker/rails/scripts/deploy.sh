#!/bin/bash

ENV_TYPE="production"
cd /home/clara/bin
if [ "$ENV_TYPE" != "production" ]; then
bundle install 
else
export RUBYOPT="-KU -E utf-8:utf-8"
fi

export ARA_DATABASE_NAME=ara_$ENV_TYPE
export ARA_DATABASE_USER=ara
export ARA_SECRET_KEY_BASE=`./rails secret`
export ARA_DATABASE_HOST=srv_db

./rails db:migrate
./rails assets:precompile
#  invoke :'deploy:cleanup'
#cp -f /home/clara/.env /var/www/ara/current/
