# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.2'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( stylesheets/custom_teaspoon.css )

dir = "#{Rails.root}/public/logs"
dir_js = "#{Rails.root}/public/logs/javascript/"
dir_css = "#{Rails.root}/public/logs/stylesheets/"
Dir.mkdir(dir) unless File.exists?(dir)
Dir.mkdir(dir_js) unless File.exists?(dir_js)
Dir.mkdir(dir_css) unless File.exists?(dir_css)

copy_file("#{Rails.root}/vendor/assets/javascripts/logster/client-app.js", "#{Rails.root}/public/logs/javascript/client-app.js")
copy_file("#{Rails.root}/vendor/assets/javascripts/logster/vendor.js", "#{Rails.root}/public/logs/javascript/vendor.js")
copy_file("#{Rails.root}/vendor/assets/stylesheets/logster/client-app.css", "#{Rails.root}/public/logs/stylesheets/client-app.css")
copy_file("#{Rails.root}/vendor/assets/stylesheets/logster/vendor.css", "#{Rails.root}/public/logs/stylesheets/vendor.css")


sk_dir = "#{Rails.root}/public/sidekiq"
sk_dir_img = "#{Rails.root}/public/sidekiq/images/"
sk_dir_js = "#{Rails.root}/public/sidekiq/javascripts/"
sk_dir_css = "#{Rails.root}/public/sidekiq/stylesheets/"
Dir.mkdir(sk_dir) unless File.exists?(sk_dir)
Dir.mkdir(sk_dir_img) unless File.exists?(sk_dir_img)
Dir.mkdir(sk_dir_js) unless File.exists?(sk_dir_js)
Dir.mkdir(sk_dir_css) unless File.exists?(sk_dir_css)

copy_file("#{Rails.root}/vendor/assets/javascripts/sidekiq/application.js", "#{Rails.root}/public/sidekiq/javascripts/application.js")
copy_file("#{Rails.root}/vendor/assets/javascripts/sidekiq/dashboard.js", "#{Rails.root}/public/sidekiq/javascripts/dashboard.js")
copy_file("#{Rails.root}/vendor/assets/images/sidekiq/status.png", "#{Rails.root}/public/sidekiq/images/status.png")
copy_file("#{Rails.root}/vendor/assets/stylesheets/sidekiq/bootstrap.css", "#{Rails.root}/public/sidekiq/stylesheets/bootstrap.css")
copy_file("#{Rails.root}/vendor/assets/stylesheets/sidekiq/application.css", "#{Rails.root}/public/sidekiq/stylesheets/application.css")
copy_file("#{Rails.root}/vendor/assets/stylesheets/sidekiq/application-dark.css", "#{Rails.root}/public/sidekiq/stylesheets/application-dark.css")
