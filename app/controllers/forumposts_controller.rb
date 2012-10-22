class ForumpostsController < ApplicationController
include ForumpostsHelper

  def index
    store_nav_history
    @messages = current_user.received_msgs.order('created_at DESC').paginate(page: params[:page], per_page: 10)  
    unless params[:city_country_location].nil?
      if find_location(params[:city_country_location])
        remember_destination(@city.id, @country.id)
        @posts = @city.forumposts.order('created_at DESC').paginate(page: params[:page], per_page: 15)
      else
        flash[:error] = "Sorry, we don't have entries for #{params[:city_country_location]} yet"
        redirect_to board_path
      end
    else
      @posts = Forumpost.order('created_at DESC').paginate(page: params[:page], per_page: 15)
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
      render 'new'
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
    sender = current_user
    	
    #Make the response into an email thread for ongoing communication	
    @message = sender.sent.build(params[:message])
    @message.recipient_id = @post.user_id
    @message.subject = "RE: #{@post.title}"
    @message.owner_id = sender.id
    @message_copy = @message.copy_message(@post.user_id) #making a copy of email for the recipient   
    @msgthread = Msgthread.build_message_thread(@message)
    @message.thread_id = @message_copy.thread_id = @msgthread.id
    if @message.save && @message_copy.save
      flash[:success] = "your message has been sent"
      redirect_to user_message_path(@post.user_id, @message)
    else
      flash[:error] = "Sorry, we were unable to send your message"
      redirect_to current_user
    end   
  end
  
  def show
    @post = Forumpost.find(params[:id])
    @user = @post.user
  end

  def respond
    @post = Forumpost.find(params[:id])
    render 'respond_post'  
  end
  
  private
  
  def verify_location(post)
    city = City.find_by_id(post.city_id)
    country = Country.find_by_id(post.country_id)
    city.is_city_of(country) unless city.nil? || country.nil?
  end
end
