class AddImagesToWorks < ActiveRecord::Migration
  def self.up
    add_attachment :works, :image
  end

  def self.down
    remove_attachment :works, :image
  end
end
