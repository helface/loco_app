module ForumpostsHelper
  
  def not_post_author(id)
    post = Forumpost.find(id)
    return current_user.id != post.user_id
  end
  
  def increment_respond_counter(id)
    #debugger
    post = Forumpost.find(id)
    post.increment(:responded_count)   
  end
end
