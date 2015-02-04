class AddFieldsToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :user_id, :integer
    add_column :notifications, :notification_type_id, :integer
  end
end
