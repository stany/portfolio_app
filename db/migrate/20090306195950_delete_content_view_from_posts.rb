class DeleteContentViewFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :content_view
  end

  def self.down
    add_column :posts, :content_view, :text
  end
end
