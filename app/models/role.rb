class Role < ActiveRecord::Base
	has_and_belongs_to_many :users, join_table: :users_roles
  has_and_belongs_to_many :default_notifications, class_name: 'NotificationType'
  belongs_to :resource, polymorphic: true

	scopify

  # ROLES:
  # ------
	# :guset
	# :user
	# :director
	# :admin
	
end
