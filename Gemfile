source 'https://rubygems.org'

ruby '2.5.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem "rails", "5.2.1.1"
gem "puma", "~> 3.0"
gem "uglifier", ">= 1.3.0"
gem "jbuilder", "~> 2.5"
gem "rack-attack"
gem "mailjet"
gem "rack", ">= 2.0.6"

gem "haml", "~> 5"
gem "haml-rails"
gem "sass-rails", "~> 5.0"
gem "pg", "~> 0.18"
gem "friendly_id", "~> 5.1.0"
gem "loofah", ">= 2.2.3"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "annotate", "2.4.0"
gem "autoprefixer-rails"
gem "active_type"
gem "bulk_insert"
gem "gon"
gem "whenever", require: false
gem "rails-html-sanitizer", ">= 1.0.4" # explicitly to avoid vulnerability issue
gem "rubyzip", "~> 1.2.2" # explicitly to avoid vulnerability issue

gem "clipboard" # debug purpose only
gem "actionpack-page_caching"
gem "awesome_print"

## Devops
gem "newrelic_rpm"
gem "sentry-raven"
gem "ruby-prof"
gem "oj"


# Admin
gem "paper_trail", "~> 9.0.0"
gem "administrate", "~> 0.10.0"
gem "administrate-field-ckeditor", "~> 0.0.8"
gem "omniauth-google-oauth2", "~> 0.5"

gem "mina", require: false
gem "mina-puma", require: false,  github: 'bdavidxyz/mina-puma'
gem "mina-multistage", require: false
gem "climate_control"
gem "fuubar"
gem "dotenv-rails"
gem "knock"
gem "bcrypt", "~> 3.1.7"
gem "google-api-client"

group :development, :test do
  gem "byebug", platform: :mri
  gem "database_cleaner", "~> 1.6"
  gem "rspec-rails"
  gem "pry-rails"
  gem "pry-stack_explorer"
  gem "pry-remote"
  gem "magic_lamp"
  gem "teaspoon-jasmine", git: 'https://github.com/bdavidxyz/teaspoon-jasmine.git'
  gem "factory_bot_rails", "~> 4.0"
end

group :test do
  gem "simplecov", require: false
  gem "capybara"
  gem "launchy"
  gem "selenium-webdriver"
  gem "poltergeist"
  gem "rack_session_access"
  gem "webmock"
  gem "coffee-rails"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  gem "rack-livereload"
  gem "rb-fsevent", require: false
  gem "letter_opener_web", "~> 1.0"
end

