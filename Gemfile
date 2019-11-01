ruby '2.6.3'
source 'https://rubygems.org'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

# Base
gem 'rails', '5.2.3'

# Infrastructure
gem 'pg'
gem 'puma'
gem 'redis'

# Controllers
gem 'has_scope'

gem 'rollbar'

gem 'rack-cors', require: 'rack/cors'

group :pry do
  gem 'awesome_print'
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  # Spring
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'

  # Linters
  gem 'brakeman', require: false
  gem 'rubocop', require: false

  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-file-permissions', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'capistrano3-puma', require: false
end

group :development, :test do
  # RSpec
  gem 'rspec-rails'

  # Spec utils, useful in dev
  gem 'factory_bot_rails'
  gem 'timecop'

  # QA
  gem 'bullet'

  gem 'faker'
end

group :test do
  gem 'database_cleaner'
end
