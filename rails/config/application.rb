require_relative 'boot'

require 'rails/all'
# require 'active_explorer'

Bundler.require(*Rails.groups)

module Mae
  class Application < Rails::Application
    config.load_defaults 6.0
    config.i18n.fallbacks = true
    config.autoload_paths << Rails.root.join('lib')
    config.public_file_server.enabled = true
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* )
    # config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    config.assets.precompile << ["*.svg", "*.eot", "*.woff", "*.ttf"]
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.autoload_paths += Dir["#{config.root}/app/view_objects/**/"]
    config.i18n.default_locale = :fr
    config.i18n.available_locales = [:fr, :en]  
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.exceptions_app = self.routes
    config.middleware.use Rack::Attack
    config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/"
    config.web_console.allowed_ips  = '172.26.0.1' if Rails.env.development?

    config.to_prepare do
      Administrate::ApplicationController.helper Mae::Application.helpers
    end
  end
end

