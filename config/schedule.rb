set :output, ENV['ARA_CRON_LOG']
set :ARA_DUMP_PATH, ENV['ARA_DUMP_PATH']

job_type :own_rake,  "cd :path && :environment_variable=:environment && ARA_DUMP_PATH=:ARA_DUMP_PATH bundle exec rake :task --silent :output"

every 1.day do
  own_rake "maintenance:db_dump"
  command "echo 'saved database at' $(date) "
end

