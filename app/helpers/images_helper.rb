module ImagesHelper
 
  def find_display_imgurl(user_id, size)
    user = User.find_by_id(user_id)
    
    if (user_id.nil? || user.nil?)
      return "http://placehold.it/260x180"
    else
      img = Image.find_by_id(user.profile_pic_id)
      if img
         if size=="large"
           return img.photo.url(:large)
         elsif size == "medium"
           return img.photo.url(:medium)
         else
           return img.photo.url(:thumb)
         end
      else
        return "full_hat.png"
      end
    end  
  end

end