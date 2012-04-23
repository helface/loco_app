module UsersHelper
  
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
    image_tag(gravatar_url, alt:user.firstname, class:"gravatar")
  end
  
  def host_user?(user)
    user.is_host
  end
end
