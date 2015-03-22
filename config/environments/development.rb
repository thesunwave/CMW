CMW::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # ActionMailer Config
  # Delivery method :smtp (default), :sendmail, :file and :test.
  # All our mail sends trought yandex smtp servers
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              Rails.application.secrets.email_provider_smtp,
    port:                 Rails.application.secrets.email_provider_port,
    domain:               Rails.application.secrets.domain_name,
    user_name:            Rails.application.secrets.email_provider_username,
    password:             Rails.application.secrets.email_provider_password,
    authentication:       Rails.application.secrets.email_authentication_type,
    enable_starttls_auto: true
  }
  config.action_mailer.default_url_options = {
    host:       Rails.application.secrets.domain_name,
    replay_to:  Rails.application.secrets.email_bot_address
  }

  # Send email
  config.action_mailer.perform_deliveries = true

  # Turn off errors in production
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.i18n.default_locale = :ru
  I18n.enforce_available_locales = true

  config.paperclip_defaults = {
  :storage => :s3,
  :s3_credentials => {
    :bucket => ENV['S3_BUCKET_NAME'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  },
  :url => ':s3_domain_url',
  :path => "/:class/:attachment/:id_partition/:style/:filename"
}

  # Allow better_errors to work with this IP
  BetterErrors::Middleware.allow_ip! Rails.application.secrets.developer_ip

  Paperclip.options[:command_path] = "/usr/bin/convert"

  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger = Logger.new("application.log")
end
