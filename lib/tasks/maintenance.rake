namespace :maintenance do  
  
  db = Rails.application.config.database_configuration[Rails.env]
  
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
