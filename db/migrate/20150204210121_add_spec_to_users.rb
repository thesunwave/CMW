class AddSpecToUsers < ActiveRecord::Migration
  def change
    add_column :users, :spec, :string
  end
end
