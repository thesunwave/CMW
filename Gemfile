source 'https://rubygems.org'
ruby '2.1.5'

gem 'rails', '4.2.0'                            # Ruby on Rails gem
gem 'sass-rails', '~> 5.0.1'                    # SASS support
gem 'compass-rails'                             # use Compass for SASS
gem 'uglifier', '>= 1.3.0'                      # JavaScript parser / mangler / compressor / beautifier
gem 'coffee-rails', '~> 4.1.0'                  # CoffeeScript support
gem 'cancan'                                    # authorization engine
gem 'devise', '~> 3.4.1'                        # authentication engine
gem 'devise-async', '~> 0.9.0'                  # provides an easy way to configure Devise to send its emails asynchronously using Delayed::Job gem 'mysql2'                                    # MySQL database support
gem 'rolify'                                    # roles engine
gem 'mysql2'                                    # mysql activerecord adapter
gem 'execjs'                                    # js runtime gem
gem 'paperclip', '~> 4.1'                       # file storage engine
gem 'delayed_job_active_record', '~> 4.0.1'     # background jobs worker
gem 'daemons', '~> 1.1.9'                       # deamon for delayed::job
gem 'http_accept_language'                      # set locale from accept-language URL header



group :development do
	gem 'better_errors'
	gem 'binding_of_caller', :platforms=>[:mri_20]
	gem 'capistrano', '~> 3.0.1'
	gem 'capistrano-bundler'
	gem 'capistrano-rails', '~> 1.1.0'
	gem 'capistrano-rails-console'
	gem 'capistrano-rvm', '~> 0.1.1'
	gem 'quiet_assets'
	gem 'rails_layout'
	gem 'faker'
	gem 'oily_png'                              # speed up the pure Ruby ChunkyPNG library
end

group :development, :test do
	gem 'rspec-rails'
	gem 'spring-commands-rspec'
	gem 'spring'
	gem 'factory_girl_rails', require: false
	gem 'guard-rspec'
	gem 'seed-fu', '~> 2.3'
end

group :test do
	gem 'capybara'                               # test web applications by simulating how a real user would interact with your app
	gem 'poltergeist'                            # poltergeist is a driver for Capybara. It allows you to run your Capybara tests on a headless WebKit browser, provided by PhantomJS
	gem 'database_cleaner', '1.0.1'              # Database Cleaner is a set of strategies for cleaning your database in Ruby
	gem 'i18n-tasks', '~> 0.7.4'                 # helps you find and manage missing and unused translations
	gem 'selenium-webdriver', '~> 2.44.0'
end


group :production do
	
end
