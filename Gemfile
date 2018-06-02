# frozen_string_literal: true
source "https://rubygems.org"
ruby "2.4.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "< 5.1"
# Use postgresql as the database for Active Record
gem "pg"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"

# Front-end
gem "bootstrap-sass"
gem "font-awesome-sass", "< 5.0"
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

# Reform
gem "reform", "~> 2.2.0"
gem "reform-rails", "~> 0.1.7"

# admin panel
gem "activeadmin"

source "https://rails-assets.org" do
  gem "rails-assets-underscore"
end

group :development, :test do
  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "factory_bot_rails"
  gem "faker"
  gem "letter_opener"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "spring"
  gem "webmock"
end

group :test do
  gem "shoulda-matchers"
end

group :production do
  gem "puma"
  gem "rack-timeout"
  gem "rails_12factor"
end
