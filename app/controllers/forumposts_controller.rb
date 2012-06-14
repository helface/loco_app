class ForumpostsController < ApplicationController
include ForumpostsHelper

  def index
    unless params[:city_country_location].nil?
      if find_location(params[:city_country_location])
        remember_destination(@city.id, @country.id)
        @posts = @city.forumposts.paginate(page: params[:page], per_page: 15)
      else
        flash[:error] = "Sorry, we don't have entries for #{params[:city_country_location]} yet"
        redirect_to forum_path
      end
    else
      @posts = Forumpost.order(:created_at).paginate(page: params[:page], per_page: 15)
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
