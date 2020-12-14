# Be sure to restart your server when you modify this file.

return unless Rails.env.test?

require 'rake'
Mae::Application.load_tasks

if defined?(CypressRails)
  CypressRails.hooks.before_server_start do
    # Called once, before either the transaction or the server is started

    # Seed the database
    Rails.application.load_seed
    ap "ENV['RAILS_ENV']"
    ap ENV['RAILS_ENV']
  end

  CypressRails.hooks.after_transaction_start do
    # Called after the transaction is started (at launch and after each reset)
  end

  CypressRails.hooks.after_state_reset do
    # Triggered after `/cypress_rails_reset_state` is called

    # See https://stackoverflow.com/a/57587210/2595513
    # truncate all data and seed database
    Rake::Task['db:seed:replant'].invoke

    CreateFakeData.new.call(Variable.find_by(name: 'v_age'))

  end

  CypressRails.hooks.before_server_stop do
    # Called once, at_exit
  end
end

