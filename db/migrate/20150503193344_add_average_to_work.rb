class AddAverageToWork < ActiveRecord::Migration
  def change
    add_column :works, :average, :float
  end
end
