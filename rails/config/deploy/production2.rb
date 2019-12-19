require 'mina/puma'

set :rails_env, 'production'

set :domain, 'localhost'
set :user, 'root'
set :application_name, 'ara'
set :deploy_to, "/var/www/ara"
set :repository, "/var/git/ara.git/clara"
set :branch, 'docker'
set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'public/uploads')
set :shared_paths, ['config/database.yml', 'log']
set :keep_releases, 2
set :forward_agent, true

set :revision, ENV['COMMIT'] 
set :commit, ENV['COMMIT']

set :deploy_to, '/var/www/ara'
set :puma_socket, '/var/www/ara/shared/tmp/sockets/puma.sock'
set :puma_pid, '/var/www/ara/shared/tmp/pids/puma.pid'
set :puma_state, '/var/www/ara/shared/tmp/sockets/puma.state'
set :pumactl_socket, '/var/www/ara/shared/tmp/sockets/pumactl.sock'
set :puma_port, 3000

task :deploy do

  # Can be called only once, therefore this security is added
  # See https://github.com/mina-deploy/mina/issues/316
  if @just_once_deploy != true
    deploy do
      comment "Deploying ARA to PRODUCTION2"
      command %{pwd}
      invoke :'git:clone'
      command %{mv ./rails/* ./}
      invoke :'deploy:link_shared_paths'
      command %{bundle install --without test development deployment}
      command %{export ARA_DATABASE_NAME=ara_production}
      command %{export ARA_DATABASE_USER=ara}
      command %{export ARA_SECRET_KEY_BASE=`bundle exec rake secret`}
      command %{export ARA_DATABASE_HOST=srv_db}
      invoke :'rails:db_migrate'
      invoke :'rails:assets_precompile'
      invoke :'deploy:cleanup'

      on :launch do
        command %{echo "reinstall env var"}
        command %{cp -f /home/clara/.env /var/www/ara/current/}
        invoke :'puma:hard_restart'
      end
    end
  end
  @just_once_deploy = true

end
