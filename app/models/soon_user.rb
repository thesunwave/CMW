class SoonUser < ActiveRecord::Base

  before_save :downcase_fields

	validates_format_of :email, presence: true, uniqueness: { case_sensitive: false },
                  with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                  message: I18n.t('errors.messages.invalid')

  def downcase_fields
    self.email.downcase!
  end
end
