source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
ruby '2.2.0'

# Libraries
####################

# gem 'recurrence'
gem 'devise' # User Authentication
gem 'thin' # Use Thin as Server

group :development, :test do
  gem 'sqlite3' # SQLite3 DB
  gem 'rspec-rails' # Test Helper
  gem 'capybara' # Feature Testing
  gem 'factory_girl_rails' #
  gem 'ffaker' # Random Fake Info
  # gem 'shoulda-matchers' # Model Testing Help for Rspec
  gem 'selenium-webdriver'
end

group :development do
  gem 'better_errors' # Better Errors
  gem 'binding_of_caller' # Better Debugging
  gem 'quiet_assets' # Shhh.. we don't need to see the assets
end

group :production do
  gem 'puma'
  gem 'pg' # Postgresql DB
  gem 'rails_12factor' # Heroku asset handler
end

## Views
####################

gem 'sass-rails', '~> 4.0.0' # Use SCSS for stylesheets
gem 'bootstrap-sass' # Pull our selves up by our Bootstraps
gem 'slim-rails' # Lose some weight

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails' # jQuery
gem 'turbolinks' # AJAXED Page Gets
gem 'jbuilder', '~> 1.2'# JSON APIs with ease
gem 'tzinfo-data', platforms: [:mingw, :mswin] # Rails Core Windows Dependency, Provides Time Zone Info

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end