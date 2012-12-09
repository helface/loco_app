class Image < ActiveRecord::Base
  belongs_to :user
  attr_accessible :photo, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  has_attached_file :photo, :styles => {:thumb => "80x70#", :medium => "400x385#", :large => "700x700>"},
                    :processors => [:cropper],
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 1.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  def clear_photo
    self.photo = nil
  end
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def reprocess
    if cropping?
       photo.reprocess!
    end
  end
  
  def img_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end

end


