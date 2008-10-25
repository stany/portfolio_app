class Project < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :description, :started_on, :user
end
