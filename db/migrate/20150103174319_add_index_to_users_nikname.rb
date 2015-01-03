class AddIndexToUsersNikname < ActiveRecord::Migration
  def change
  	add_index :users, :nikname, unique: true
  end
end
