# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'devise'
gem 'interactor-rails', '~> 2.0'
gem 'nokogiri', '>= 1.10.4'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'chartkick'
gem 'groupdate'

# Boostrap 4 dependencies
gem 'bootstrap', '>= 4.3.1'
gem 'jquery-rails'

# Payment dependencies
gem 'pagarme'

# Rails admin
gem 'rails_admin'

# AutoComplete ZipCode
gem 'autocomplete_zipcode'

# Generate reports with Blazer
gem 'blazer'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'libv8', '7.3.492.27.1'
gem 'mini_racer', '0.2.9'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# use slim html
gem 'slim-rails'

# custom error pages with Exception Handler
gem 'exception_handler', '~> 0.8.0.0'

# Environment configuration
gem 'figaro'

# HubSpot integration
gem 'hubspot-ruby', '~> 0.9.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Healthcheck
  gem 'rails-healthcheck'
  gem 'dotenv-rails'

  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'parity'              # automate deployment
  gem 'pry-byebug'          # local debugging
  gem 'sqlite3'             # database for local development
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'annotate'
  gem 'html2slim'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Code Quality tools
  gem 'rubocop', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'webdrivers'
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
