source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '4.0.9'
gem 'rails-api'
gem 'mongoid', '~> 4', github: 'mongoid/mongoid'
gem 'rack-jsonp-middleware'
gem 'rack-cors', require: 'rack/cors'
gem 'doorkeeper'
gem 'unicorn'
gem 'bson_ext'
gem 'draper'
gem 'yajl-ruby'
gem 'rails_config'
gem 'active_model_serializers'
gem 'dalli'
gem 'foreman'
gem 'kaminari'
gem 'devise'
gem 'addressable'
gem 'jquery-rails'
gem 'rack-protection'

group :development do
  gem 'rubocop'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'capybara'
  gem 'capybara-json'
  gem 'factory_girl_rails', require: false
  gem 'hashie'
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'delorean'
  gem 'spork', '~> 1.0rc'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'growl'
  gem 'webmock'
  gem 'rb-fsevent'
  gem 'dotenv-rails'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production do
  gem 'rails_12factor'
end
