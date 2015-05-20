require 'active_support/concern'
require 'addressable/uri'
require 'simpleidn'
require 'faraday'
 
# Normalize and validate URLs
module Urlable
  extend ActiveSupport::Concern
 
  included do
    before_validation :normalize_url
    validates :facebook, presence: true, uniqueness: true
    #validate :check_url, if: :url_changed?
  end
 
  private
 
  def normalize_url
    url = self.facebook
    @uri = Addressable::URI.heuristic_parse(url)
    self.facebook = @uri.to_s
  end
 
  def check_url
    res = Faraday.get @uri.normalize.to_s do |req|
      req.options[:timeout] = 7
      req.options[:open_timeout] = 7
    end
    rescue Faraday::Error::TimeoutError, Faraday::Error::ConnectionFailed, URI::InvalidURIError, Errno::EHOSTUNREACH
      fail_check!
    rescue Zlib::DataError, Zlib::BufError
      return true
    else
      return true if res.status.to_s =~ /^[2|3]/
      fail_check!
  end
 
  def fail_check!
    errors.add :url, I18n.t('activerecord.errors.messages.open_url_error')
    false
  end
end