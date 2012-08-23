source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'

gem 'json'

gem 'jquery-rails'
gem 'simplecov'
gem 'haml'
gem 'yaml_db' # For copying/loading database states

gem "bcrypt-ruby", :require => "bcrypt" # For encrypting passwords.
gem "cancan" # To handle user authentication 
gem "faye"
gem "thin"
gem "rufus-scheduler"
gem "dynamic_form" # for dynamic form validation

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end


# for Heroku deployment - as described in Ap. A of ELLS book
group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug'
  # gem 'cucumber-rails'  # Received a warning that 'Cucumber-rails required outside of env.rb.  The rest of loading is being defered until env.rb is called.
    #To avoid this warning, move 'gem cucumber-rails' under only group :test in your Gemfile'  So I moved the gem to the test environment.
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  # gem 'simplecov'  # simplecov requires ruby 1.9.2 to run and I'm running 1.8.7.  I keep getting warnings about this, so I'm deactivating this gem.
  gem 'ZenTest'
end
group :production do
  gem 'pg'
end
group :test do
  gem 'cucumber-rails'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'



