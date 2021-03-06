# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read('.ruby-version')

gem 'activerecord-precounter'
gem 'awesome_nested_fields'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap-kaminari-views'
gem 'bootstrap-sass', '~> 2.3.2.2'
gem 'bootstrap_file_input_rails', '>= 1.0.0'
gem 'carrierwave-postgresql', '< 0.3.0' # Can be upgraded once https://github.com/diogob/carrierwave-postgresql/issues/33
gem 'chartkick'
gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'devise'
gem 'filterrific'
gem 'formtastic'
gem 'geocoder'
gem 'groupdate'
gem 'haml-rails'
gem 'highcharts-rails'
gem 'highline'
gem 'jquery-rails'
gem 'kaminari'
gem 'kramdown'
gem 'obscenity'
gem 'paper_trail'
gem 'paper_trail-association_tracking'
gem 'passenger', require: 'phusion_passenger/rack_handler'
gem 'pg'
gem 'prawn'
gem 'rails', '~> 5.2.1'
gem 'rails_admin', '~> 2.0', git: 'https://github.com/sferik/rails_admin.git'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'rubyzip'
gem 'sentry-raven'

group :development do
  gem 'letter_opener'
  gem 'listen'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-remote'
end

group :test do
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'rails-controller-testing'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier'
end

group :production do
  gem 'scout_apm'
end
