class AddVkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vk, :string
  end
end
