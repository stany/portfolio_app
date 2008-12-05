class AddCompanyIdToProject < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.remove :company
      t.integer :company_id
    end
  end

  def self.down
    change_table :projects do |t|
      t.string :company
      t.remove :company_id
    end
  end
end
