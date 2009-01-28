class Company < ActiveRecord::Base

  validates_presence_of :name, :if => Proc.new {|c| c.url.blank?}
  validates_presence_of :url, :if => Proc.new {|c| c.name.blank?}
  validates_format_of :url, :with => /^http:\/\/.+\..{2,3}$/i, :allow_blank => true
  
  has_many :projects
  
end
