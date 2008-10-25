class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.text :description_view
      t.date :started_on
      t.date :ended_on
      t.string :company

      t.timestamps
    end
    add_index :projects, :user_id
  end

  def self.down
    drop_table :projects
  end
end
