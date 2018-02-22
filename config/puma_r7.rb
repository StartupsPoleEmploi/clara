environment "production"

bind  "unix:///var/www/mae/shared/tmp/sockets/puma.sock"
pidfile "/var/www/mae/shared/tmp/pids/puma.pid"
state_path "/var/www/mae/shared/tmp/sockets/puma.state"
directory "/var/www/mae/current"

workers 2
threads 1,2

daemonize true

activate_control_app 'unix:///var/www/mae/shared/tmp/sockets/pumactl.sock'

port 3000

prune_bundler
