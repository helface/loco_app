class Image < ActiveRecord::Base
  belongs_to :user
  attr_accessible :photo, :crop_x, :crop_y, :crop_w, :crop_h, :width_ratio
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :width_ratio
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
    
  def get_original_dimensions
    temp_orig = photo.queued_for_write[:original]
    temp_large = photo.queued_for_write[:large]
    
    orig_width = Paperclip::Geometry.from_file(temp_orig).width
    large_width = Paperclip::Geometry.from_file(temp_large).width
    @width_ratio = orig_width/large_width
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


