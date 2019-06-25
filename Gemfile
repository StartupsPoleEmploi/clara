source 'https://rubygems.org'

ruby '2.6.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem "rails", "5.2.2.1", group: "undefined"
gem "puma", "~> 3.0", group: "undefined"
gem "uglifier", ">= 1.3.0", group: "undefined"
gem "jbuilder", "~> 2.5", group: "undefined"
gem "rack-attack", group: "undefined"
gem "mailjet", group: "undefined"
gem "kaminari", group: "undefined"
gem "pg_search", group: "undefined"
gem "rack", ">= 2.0.6", group: "undefined"

gem "haml", "~> 5", group: "undefined"
gem "haml-rails", group: "undefined"
gem "sass-rails", "~> 5.0", group: "undefined"
gem "pg", "~> 0.18", group: "undefined"
gem "friendly_id", "~> 5.1.0", group: "undefined"
gem "loofah", ">= 2.2.3", group: "undefined"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby], group: "undefined"
gem "autoprefixer-rails", group: "undefined"
gem "active_type", group: "undefined"
gem "bulk_insert", group: "undefined"
gem "gon", group: "undefined"
gem "whenever", require: false, group: "undefined"
gem "rails-html-sanitizer", ">= 1.0.4" # explicitly to avoid vulnerability issue, group: "undefined"
gem "rubyzip", "~> 1.2.2" # explicitly to avoid vulnerability issue, group: "undefined"

gem "clipboard" # debug purpose only, group: "undefined"
gem "actionpack-page_caching", group: "undefined"
gem "awesome_print", group: "undefined"
gem "seed_dump", group: "undefined"

## Devops
gem "newrelic_rpm", group: "undefined"
gem "sentry-raven", group: "undefined"
gem "ruby-prof", group: "undefined"
gem "oj", group: "undefined"
gem "bundle-only", group: "undefined"


# Admin
gem "paper_trail", "~> 9.0.0", group: "undefined"
gem "administrate", group: "undefined"

gem "administrate-field-ckeditor", "~> 0.0.8", group: "undefined"
# gem "omniauth-google-oauth2", group: "undefined"

gem "mina", require: false, group: "deployment"
gem "mina-puma", require: false, github: 'bdavidxyz/mina-puma', group: "deployment"
gem "mina-multistage", require: false, group: "deployment"
gem "climate_control", group: "undefined"
gem "fuubar", group: "undefined"
gem "dotenv-rails", group: "undefined"
gem "knock", group: "undefined"
gem "bcrypt", "~> 3.1.7", group: "undefined"
gem "google-api-client", group: "undefined"
gem "i18n-js", group: "undefined"
gem "administrate_exportable", github: 'bdavidxyz/administrate_exportable', group: "undefined"
gem "clearance", group: "undefined"
gem "bootsnap", group: "undefined"

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
  gem "mocha"
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
  gem "annotate", "2.4.0"
end

