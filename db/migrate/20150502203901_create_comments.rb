class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :work_id
      t.text :text
      t.integer :rating

      t.timestamps null: false
    end
  end
end
