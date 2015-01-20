class AddBehanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :behance, :string
  end
end
