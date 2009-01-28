class Asset < ActiveRecord::Base
  has_attached_file :photo, 
      :styles => { 
         :thumb => "100x100>", 
         :medium => "300x300>" 
      }
  belongs_to :project
  validates_presence_of :project
end
