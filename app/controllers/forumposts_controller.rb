class ForumpostsController < ApplicationController
include ForumpostsHelper

  def index
    if !params[:city].nil?
      city = City.find(params[:city][:id]) 
      @posts = city.forumposts
    else
      @posts = Forumpost.all
    end
  end
  
  def new
    @post = Forumpost.new
  end
  
  def create
     #TODO: have the posts automatically expire in 7 days
    @post = current_user.forumposts.build(params[:forumpost])
    if @post.save
      flash[:success] = "Your post has been successfully posted"
      redirect_to @post
    else
      flash[:error] = "You post failed."
      redirect_to forum_path
    end
  end
  
  def create_response
    #TODO: maybe limit the number of posts you can respond to at any given time.
    @post = Forumpost.find(params[:id])
    @post.increment!(:responded_count)
    build_message_thread
  end
  
  def show
    @post = Forumpost.find(params[:id])
  end

  def respond
    @post = Forumpost.find(params[:id])
    render 'respond_post'  
  end
end
