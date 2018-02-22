require 'tasks/utils'

namespace :maintenance do  
  
  db = Rails.application.config.database_configuration[Rails.env]
  
  desc "Import production database locally"
  task :transfer_ara_from_sandbox_to_dev do
    app = 'mae-attempt'
    run_and_stop_if_error "heroku pg:backups capture --app #{app}"
    url = run_and_stop_if_error("heroku pg:backups public-url -q --app #{app}")
    puts `curl -o #{ara_dump_path} "#{url}"`
    username_option = db['username'].blank? ? nil : "-U #{db['username']}"
    puts `pg_restore --verbose --clean --no-acl --no-owner -h localhost #{username_option} -d ara #{ara_dump_path}`
  end

  def ara_dump_path
    ENV['ARA_DUMP_PATH']
  end

  def db_name
    config = Rails.configuration.database_configuration[Rails.env]

    puts "Rails.env is #{Rails.env}"

    forced_name = 'ara_production'
    puts "forced_name to #{forced_name} instead of #{config['database']}"

    "postgresql://#{config['username']}:#{config['password']}@127.0.0.1:5432/#{forced_name}"
  end

  task :db_dump do
    if ara_dump_path
      system "pg_dump -Fc --no-owner --dbname=#{db_name} > #{ara_dump_path}"
    else
      puts 'please specify a ARA_DUMP_PATH env var'
    end
  end

  task :db_load do
    system "pg_restore --clean --no-owner --dbname=#{db_name} #{ara_dump_path}"
  end

end
