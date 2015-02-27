class SoonUser < ActiveRecord::Base
	validates_format_of :email, presence: true, uniqueness: { case_sensitive: false }, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: I18n.t('errors.messages.invalid')
end
