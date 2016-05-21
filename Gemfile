source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Framework CSS
gem 'bootstrap-sass', '~> 3.3.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Markdown
gem 'redcarpet'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Framework test
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
  # Fixtures for feeding test data
  gem 'factory_girl_rails', '~> 4.7'
  # Automatically run your specs
  gem 'guard-rspec', '~> 4.6', '>= 4.6.5'
  # Rspec command for spring
  gem 'spring-commands-rspec', '~> 1.0', '>= 1.0.4'
end

group :test do
  # Generate data test
  gem 'faker', '~> 1.6', '>= 1.6.3'
  # It simulates how a user would interact with a website
  gem 'capybara', '~> 2.7', '>= 2.7.1'
  # Helps make sure each spec run in RSpec begins with a clean slate
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
  # Is helper class for launching cross-platform applications in a fire and forget manner.
  gem 'launchy', '~> 2.4', '>= 2.4.3'
  # WebDriver is a tool for writing automated tests of websites
  gem 'selenium-webdriver', '~> 2.53'
  # Making tests easy on the fingers and eyes
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
end

group :development do
  # Annotates models, routes and fixtures
  gem 'annotate'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'rails_12factor'
end