require 'mina/rbenv'
require 'mina/puma'

set :rbenv_path, "$HOME/.rbenv"

set :rails_env, 'production'

set :domain, '192.168.4.122'
set :user, 'dboureau'
set :application_name, 'ara'
set :deploy_to, "/var/www/ara"
set :repository, "/var/git/ara.git"
set :branch, 'master'
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

task :environment do
  # Can be called many times
  puts 'setting env for r7'
  invoke :'rbenv:load'
end

task :deploy do

  # Can be called only once, therefore this security is added
  # See https://github.com/mina-deploy/mina/issues/316
  if @just_once_deploy != true
    deploy do
      comment "Deploying ARA to R7"
      command %{pwd}
      invoke :'git:clone'
      invoke :'deploy:link_shared_paths'
      invoke :'bundle:install'
      command %{export ARA_DATABASE_NAME=ara_production}
      command %{export ARA_DATABASE_USER=ara}
      invoke :'rails:db_migrate'
      invoke :'rails:assets_precompile'
      command %{export ARA_SECRET_KEY_BASE=`bundle exec rake secret`}
      invoke :'deploy:cleanup'

      on :launch do
        command %{echo "reinstall env var"}
        command %{cp -f /home/dboureau/.env /var/www/ara/current/}
        invoke :'puma:hard_restart'
      end
    end
  end
  @just_once_deploy = true

end
