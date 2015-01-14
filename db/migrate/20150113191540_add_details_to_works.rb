class AddDetailsToWorks < ActiveRecord::Migration
  def change
    add_column :works, :user_id, :integer
    add_column :works, :image_file_id, :integer
    add_column :works, :title, :string
    add_column :works, :views_count, :integer, default: 0
    add_column :works, :favs_count, :integer, default: 0
    add_column :works, :description, :text
    add_column :works, :tags, :text
  end
end
