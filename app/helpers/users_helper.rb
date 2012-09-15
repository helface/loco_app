module UsersHelper
  
  def host_user?(user)
    user.try(:is_host)
  end
end
