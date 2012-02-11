source 'http://rubygems.org'

gem 'rails'
gem 'bcrypt-ruby'
gem 'faker'
gem 'will_paginate'

group :development do
  gem 'sqlite3'
  gem 'annotate'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'

group :test, :development do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'spork'
end

group :test do
  gem 'capybara'
  gem 'rb-fsevent', require: false
  gem 'growl'
  gem 'factory_girl_rails'
  gem 'cucumber-rails'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
end
