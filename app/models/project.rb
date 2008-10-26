class Project < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :description, :started_on, :user
  
  before_save :liquidize

  private
  def liquidize
    self.description_view = RedCloth.new(Liquid::Template.parse(self.description).render).to_html
  end
end
