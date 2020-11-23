if ENV['COVERAGE_PLEASE'] == 'true'
  require 'simplecov'
  SimpleCov.start 'rails' do
    coverage_dir "coverage/ruby/functional".to_s
    add_filter "app/jobs/application_job.rb"
    add_filter "app/services/pe_connect_service.rb"
    add_filter "bin/spring"
    add_filter "app/channels/application_cable/channel.rb"
    add_filter "app/channels/application_cable/connection.rb"
  end
  puts "required simplecov for functional testing"
end
