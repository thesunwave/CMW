require 'rails_helper'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.default_wait_time = 8 # Seconds to wait before timeout error. Default is 2

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { debug: false, # change this to true to troubleshoot
                                           window_size: [1300, 1000], # this can affect dynamic layout
                                           js_errors: false
  })
end

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  # force set locale to RU for integrational tests
  config.before :example, js: true do
    I18n.locale = :ru
  end
end

# Saves page to place specfied at name inside of
# test.rb definition of:
#   config.integration_test_render_dir = Rails.root.join("spec", "render")
# NOTE: you must pass "js:" for the scenario definition (or else you'll see that render doesn't exist!)
def render_page(name)
  png_name = name.strip.gsub(/\W+/, '-')
  path = File.join(Rails.application.config.integration_test_render_dir, "#{png_name}.png")
  page.save_screenshot(path)
end

# shortcut for typing save_and_open_page
def page!
  save_and_open_page
end
