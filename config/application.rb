require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Mae
  class Application < Rails::Application
    config.public_file_server.enabled = true
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* )
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.autoload_paths += Dir["#{config.root}/app/view_objects/**/"]
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
    config.i18n.default_locale = :fr
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.exceptions_app = self.routes
    config.middleware.use Rack::Attack
    config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/"
    # To active ressources compression: https://stackoverflow.com/questions/13734608/compressing-rails-assets-and-nginx-gzip/27964220#27964220
    config.middleware.insert_before(Rack::Sendfile, Rack::Deflater)
    # Compress JavaScripts and CSS.
    config.assets.compress = true
    config.assets.js_compressor = Uglifier.new(mangle: false)

  end
end

