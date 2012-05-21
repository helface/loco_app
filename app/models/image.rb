class Image < ActiveRecord::Base
  belongs_to :user
  attr_accessible :caption, :photo
  has_attached_file :photo, :styles => {:thumb => "100x200#", :medium => "300x300", :large => "800x600>"}
  
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def clear_photo
    self.photo = nil
  end
end
