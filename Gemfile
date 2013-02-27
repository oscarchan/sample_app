source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass', '2.1'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '~> 1.2'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'rspec-rails', '~> 2.12'
  gem 'rspec', '~> 2.12'

  # use capybara 1.x because of bug: https://github.com/jnicklas/capybara/issues/844
  gem 'capybara', '~> 1.0'
  gem 'factory_girl_rails', '~> 3.4'
  gem 'sqlite3'

  gem 'guard-rspec', '1.2.1'
  gem 'guard-spork', '1.2.0'
  gem 'spork', '0.9.2'
end

# Platform dependency
gem 'rb-fsevent', '0.9.1', :require => false, :group => :test
gem 'growl', '1.0.3', :group => :test

group :production do
  gem 'pg', '0.12.2'
end

