source 'https://rubygems.org'

ruby "1.9.3"

gem 'rails', '>=3.2.13'

group :production do
  gem 'pg'
end
group :development do
  gem "rspec-rails", ">= 2.8.1"
  gem 'rails-erd'
  gem "heroku_san"
  gem "guard"
  gem "guard-bundler"
  gem "guard-coffeescript"
  gem "guard-rails"
  gem 'guard-annotate'
  gem 'quiet_assets'
# gem 'debugger', '~> 1.1.4'
  gem 'sextant' # Help me see routes in browser. Go to /rails/routes to see them
  gem 'better_errors' # Better errors from https://github.com/charliesome/better_errors
  gem "binding_of_caller"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
end

gem 'sass-rails',   '~> 3.2.3'
gem 'jquery-rails'

# Bundle the extra gems:
gem 'simple_form'
gem 'nested_form'
gem 'country_select'
gem 'carrierwave'
# gem 'kaminari' #pagination
gem "haml", ">= 3.1.4"
gem "haml-rails", ">= 0.3.4"
gem "devise", ">= 2.0.0"
gem 'hpricot'
gem 'ruby_parser'
gem 'cancan'
gem 'activemerchant', '>= 1.20.1'
gem "better_states_select"
gem 'will_paginate'
gem 'bootstrap-will_paginate'
# gem 'kaminaris'
gem 'event-calendar', :require => 'event_calendar'
gem "watu_table_builder", :require => "table_builder"
gem "paperclip", "~> 3.0"
gem "aws-sdk"
#gem "rmagick"
gem "remotipart", "~> 1.0"
gem 'validates_timeliness', '~> 3.0'

gem 'client_side_validations', '3.2.1', :git => 'https://github.com/bcardarella/client_side_validations.git'
gem 'less-rails-bootstrap'
gem 'therubyracer'
#gem "execjs"
gem "friendly_id", "~> 4.0.1"

gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'bootstrap-datepicker-rails'

# This gem breaks compilation, be sure to activate it later
#gem 'lazy_high_charts', '~> 1.1.5'

group :test do
 # gem "factory_girl_rails"
 # gem 'faker'
 # gem 'spork'
end

gem "garb";
gem 'rack-google_analytics','1.0.2'
gem "google_visualr", ">= 2.1"
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'rvm-capistrano'