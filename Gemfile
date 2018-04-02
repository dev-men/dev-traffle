source 'https://rubygems.org'
ruby '2.5.0'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end



gem 'rack-cors', :require => 'rack/cors'

gem 'aws-sdk', '< 3.0'
gem 'aws-sdk-s3', '~> 1.8', '>= 1.8.2'
gem 'json_pure', '~> 2.1'
gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"

# Progress Bar gem
gem 'bootstrap_progressbar'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use Puma as the app server
gem 'puma', '~> 3.7'
gem 'country_select'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.7'
gem 'sass-rails', '~> 5.0'
# Progress Bar gem
gem 'bootstrap_progressbar'
gem 'jquery-rails'
# Pagination Gem
gem 'will_paginate-bootstrap'
gem 'will_paginate', '~> 3.1.0'

# Data Table for All Users
gem 'jquery-datatables'
# Use Devise Gem For authentication
gem 'devise'
gem 'simple_token_authentication', '~> 1.0'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'
gem 'omniauth-google-oauth2'
#PayStack gem for payment integration
gem 'paystack'


gem "figaro"
#Use for datetime validation
gem 'validates_timeliness', '~> 4.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

#Use for nested form fields
gem "cocoon"

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  gem 'sqlite3'
end

group :production do
  gem 'pg', '~> 0.20'
  gem 'rails_12factor'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
