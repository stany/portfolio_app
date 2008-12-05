class Company < ActiveRecord::Base

  validates_presence_of :name, :url
  
  has_many :projects
  
end
