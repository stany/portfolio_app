class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :tags
  
  validates_presence_of :title, :content, :user
  
  before_save :htmlize
  
  private
  def htmlize
    self.content_view = RedCloth.new(self.content).to_html
  end
end
