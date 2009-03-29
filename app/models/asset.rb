class Asset < ActiveRecord::Base
  has_attached_file :photo, 
      :styles => { 
         :thumb => "100x100>", 
         :medium => "300x300>" 
      }
  belongs_to :project
  validates_presence_of :project
  
  def flash_photo=(data)
    data.content_type = MIME::Types.type_for(data.original_filename).to_s
    self.photo = data
  end
end
