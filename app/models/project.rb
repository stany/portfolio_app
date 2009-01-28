class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates_presence_of :title, :description, :started_on, :user
  validates_associated :company, :on => :save
  
  after_update :save_company
  
  before_save :liquidize

  acts_as_taggable_on :tags

  has_many :assets

  def company_attributes=(attributes)
    if self.company
      self.company.attributes = attributes
    else
      self.company = Company.new(attributes)
    end
  end

  private
  
  def save_company
    self.company.save(false)
  end
  
  def liquidize
    self.description_view = RedCloth.new(Liquid::Template.parse(self.description).render).to_html
  end
end
