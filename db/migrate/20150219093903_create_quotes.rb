class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :text_rus
      t.string :text_eng
      t.string :author_rus
      t.string :author_eng

      t.timestamps null: false
    end
  end
end
