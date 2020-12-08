# Be sure to restart your server when you modify this file.

return unless Rails.env.test?

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
    created_aid = Aid.find_by(slug: 'erasmus42')
    if created_aid
      created_aid.destroy
    end
    created_ct = ContractType.find_by(slug: 'aide-a-la-mobilisation')
    if created_ct
      created_ct.destroy
    end
    created_filter = Filter.find_by(slug: 'deplacement')
    if created_filter
      created_filter.destroy
    end
    created_contributeur = User.find_by(email: 'contributeur1@clara.com')
    unless created_contributeur
      User.create(email: "contributeur1@clara.com", password: "contributeur1", role: "contributeur")
    end
  end

  CypressRails.hooks.before_server_stop do
    # Called once, at_exit
  end
end

