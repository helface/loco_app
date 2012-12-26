module ImagesHelper
 
  def find_display_imgurl(user_id, size)
    user = User.find_by_id(user_id)
    img = Image.find_by_id(user.profile_pic_id) unless user.nil?
    if img
       if size=="large"
          url = img.photo.url(:large)
       elsif size == "medium"
          url = img.photo.url(:medium)
       else
          url = img.photo.url(:thumb)
       end
    else
      user.fb_profilepic_url.nil? ? "full_hat.png" : user.fb_profilepic_url
    end
  end
end