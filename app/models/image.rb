class Image < ActiveRecord::Base
  belongs_to :user
  attr_accessible :photo
  has_attached_file :photo, :styles => {:thumb => "115x100#", :medium => "345x300#", :large => "690x600#"},
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 3.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  def clear_photo
    self.photo = nil
  end
end
