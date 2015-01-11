source 'https://rubygems.org'
ruby '2.1.5'

gem 'rails', '4.1.4'                            # Ruby on Rails gem
gem 'sass-rails', '~> 4.0.0'                    # SASS support
gem 'compass-rails'                             # use Compass for SASS
gem 'uglifier', '>= 1.3.0'                      # JavaScript parser / mangler / compressor / beautifier
gem 'coffee-rails', '~> 4.0.0'                  # CoffeeScript support
gem 'cancan'                                    # authorization engine
gem 'devise', '~> 3.3'                          # authentication engine
gem 'devise-async', '~> 0.9.0'                  # provides an easy way to configure Devise to send its emails asynchronously using Delayed::Job gem 'mysql2'                                    # MySQL database support
gem 'rolify'                                    # roles engine
gem 'mysql2'                                    # mysql activerecord adapter
gem 'paperclip', '~> 4.1'                       # file storage engine



group :development do
	gem 'better_errors'
	gem 'quiet_assets'
	gem 'oily_png'                              # speed up the pure Ruby ChunkyPNG library
	gem 'sqlite3', '1.3.8'
end


group :development, :test do
	gem 'rspec-rails'
	gem 'guard-rspec'
	gem 'factory_girl_rails', require: false
	gem 'seed-fu', '~> 2.3'
end

group :test do
	gem 'capybara'                               # test web applications by simulating how a real user would interact with your app
	gem 'poltergeist'                            # poltergeist is a driver for Capybara. It allows you to run your Capybara tests on a headless WebKit browser, provided by PhantomJS
	gem 'i18n-tasks', '~> 0.7.4'                 # helps you find and manage missing and unused translations
	gem 'database_cleaner', '1.0.1'              # Database Cleaner is a set of strategies for cleaning your database in Ruby
end


group :production do
	
end
