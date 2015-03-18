class NotificationType < ActiveRecord::Base
  has_many :notifications
  has_many :users, through: :notifications
  has_and_belongs_to_many :default_for, class_name: 'Role'
end
