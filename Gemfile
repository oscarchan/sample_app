source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'bootstrap-sass', '2.1'
  gem 'coffee-rails', '3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.0.2'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'

group :development, :test do
  gem 'rspec-rails', '2.11.0'
  gem 'cucumber-rails', '1.2.1', require: false
  gem 'database_cleaner', '0.7.0'
  #gem 'rspec', '2.6.1'

  # use capybara 1.x because of bug: https://github.com/jnicklas/capybara/issues/844
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '~> 3.4'
  gem 'sqlite3'

  gem 'guard-rspec', '1.2.1'
  gem 'guard-spork', '1.2.0'
  gem 'spork', '0.9.2'
  gem 'faker', '1.0.1'
end

# Platform dependency
gem 'rb-fsevent', '0.9.1', :require => false, :group => :test
gem 'growl', '1.0.3', :group => :test

group :production do
  gem 'pg', '0.12.2'
end

