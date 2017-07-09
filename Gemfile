# frozen_string_literal: true
source "https://rubygems.org"
ruby "2.4.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "5.0.4"
# Use postgresql as the database for Active Record
gem "pg"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc

# Front-end
gem "bootstrap-sass"
gem "font-awesome-sass"
gem "simple_form"

# other
gem "devise"
gem "devise-i18n"
gem "devise-i18n-views"
gem "figaro"
gem "geocoder"
gem "gmaps4rails"
gem "icalendar"
gem "modernizr-rails"
gem "omniauth-facebook"
gem "premailer-rails"
gem "pundit"
gem "raygun4ruby"

# For manual updates on cities
gem "google_places"

# Background-jobs
gem "sidekiq"

# Trailblazer
gem "reform", "~> 2.1.0"
gem "trailblazer-loader"
gem "trailblazer-rails"

# admin panel
gem "activeadmin"

source "https://rails-assets.org" do
  gem "rails-assets-underscore"
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "factory_girl_rails"
  gem "faker"
  gem "letter_opener"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "spring"
end

group :test do
  gem "shoulda-matchers"
end

group :production do
  gem "puma"
  gem "rack-timeout"
  gem "rails_12factor"
end
