class AddDribbleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dribble, :string
  end
end
