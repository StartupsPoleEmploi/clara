
if defined?(CypressRails)
  CypressRails.hooks.before_server_start do
    # Called once, before either the transaction or the server is started
  end

  CypressRails.hooks.after_transaction_start do
    # Called after the transaction is started (at launch and after each reset)
  end

  CypressRails.hooks.after_state_reset do
    # Triggered after `/cypress_rails_reset_state` is called
  end

  CypressRails.hooks.before_server_stop do
    # Called once, at_exit
  end# Be sure to restart your server when you modify this file.
end

# Version of your assets, change this if you want to expire all your assets.
# Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
# Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
