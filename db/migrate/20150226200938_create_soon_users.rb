class CreateSoonUsers < ActiveRecord::Migration
  def change
    create_table :soon_users do |t|

      t.timestamps null: false
    end
  end
end
