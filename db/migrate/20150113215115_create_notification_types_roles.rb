class CreateNotificationTypesRoles < ActiveRecord::Migration
  def change
    create_table :notification_types_roles do |t|
      t.integer :notification_type_id, null: false
      t.integer :role_id, null: false

      t.timestamps null: false
    end
  end
end
