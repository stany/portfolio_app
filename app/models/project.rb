class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates_presence_of :title, :description, :started_on, :user
  
  before_save :liquidize

  acts_as_taggable_on :tags

  private
  def liquidize
    self.description_view = RedCloth.new(Liquid::Template.parse(self.description).render).to_html
  end
end
