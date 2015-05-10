class AddAverageToWork < ActiveRecord::Migration
  def change
    add_column :works, :average, :float, default: 0
  end
end
