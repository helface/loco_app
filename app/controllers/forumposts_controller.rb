class ForumpostsController < ApplicationController
include ForumpostsHelper

  def index
    if !params[:city].nil?
      city = City.find(params[:city][:id]) 
      @posts = city.forumposts
    else
      #TODO: do i want this?
      @posts = Forumpost.all
    end
  end
  
  def new
    @post = Forumpost.new
  end
  
  def create
     #TODO: have the posts automatically expire in 7 days
    @post = current_user.forumposts.build(params[:forumpost])
    if !verify_location(@post)
      redirect_to root_path
    else  
      if @post.save 
        flash[:success] = "Your post has been successfully posted"
        redirect_to @post
      else
        flash[:error] = "Your post failed"
        redirect_to forum_path
      end
    end
  end
  
  def manage_posts
    @posts = current_user.forumposts
    render 'manage_posts'
  end
  
  def create_response
    #TODO: maybe limit the number of posts you can respond to at any given time.
    @post = Forumpost.find(params[:id])
    @post.increment_respond_count
    build_message_thread
  end
  
  def show
    @post = Forumpost.find(params[:id])
  end

  def respond
    @post = Forumpost.find(params[:id])
    render 'respond_post'  
  end
  
  private
  
  def verify_location(post)
    city = City.find_by_id(post.city_id)
    country = Country.find_by_id(post.country_id)
    city.is_city_of(country)
  end
end
