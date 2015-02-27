class AddEmailToSoonUsers < ActiveRecord::Migration
  def change
    add_column :soon_users, :email, :string
  end
end
