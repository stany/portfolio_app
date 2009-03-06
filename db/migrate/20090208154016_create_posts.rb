class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.belongs_to :user
      t.string :title
      t.text :content, :content_view
      t.timestamps
    end
    add_index :posts, :user_id, :name => 'user_id_index'
  end

  def self.down
    drop_table :posts
  end
end
