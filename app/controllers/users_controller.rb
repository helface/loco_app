class UsersController < ApplicationController
#TODO: user friendly URL to hide user id. Use to_param or something similar
respond_to :html, :json
before_filter :signed_in_user, only: [:edit, :update, :destroy, :recommend, :update_profile_pic]    
before_filter :active_user, only: [:show]
before_filter :correct_user, only: [:edit, :update, :update_profile_pic, :deactivate]
before_filter :location_specified, only: :index
#before_filter :admin_user, only: :destroy
    
 
  def index  
      store_nav_history
      @users = @city.hosts.paginate(page: params[:page], per_page: 9)
  end

  def show
    session[:form_step] = session[:form_params] = nil
    @token = params[:token]  
    @reviews = @user.inverse_reviews.paginate(page: params[:page], per_page: 10)
    @treviews = @user.treviews_received.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def edit
    store_nav_history
    @image = Image.new
    @user = User.find(params[:id])
    @hostprofile = @user.hostprofile
  end

  def create
    @user = User.new(params[:user])
    if @user.save        
        flash[:success] = "Congratulations! A confirmation email has been sent to your inbox for activation."
        SiteMailer.signup_confirmation(@user).deliver
        #Enable when deploying sidekiq
        #MailerWorker.perform_async(@user.id)
        redirect_to signin_path
    else
        render 'new'
    end
  end
  
  def update        
    @user = User.find_by_id(params[:id])
    if !params[:user][:old_password].nil?
      if !@user.authenticate(params[:user][:old_password])
        flash[:error] = "Must enter your current password correctly"
        redirect_to edit_user_path(@user)
        return
      else
        params[:user].delete :old_password
      end
    end
    if @user.update_attributes(params[:user])
       flash[:success] = "Profile successfully updated"
       sign_in @user
       redirect_to session[:prev]
       return
       #respond_with @user, location: user_path(@user)
    else
       flash[:error] = "failed to update profile #{@user.errors.full_messages}"
       redirect_to edit_user_path(@user, view: "general")     
    end
  end

  def update_profile_pic
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(:profile_pic_id => params[:img_id])
      flash[:success] = "Profile picture successfully updated"
      sign_in @user
      redirect_to @user
    else
      flash[:error] = "#{@user.errors.full_messages}"
      redirect_to session[:prev]
    end
  end
 
 
  def destroy
    @user = User.find(params[:id])
    #@user.destroy
    redirect_to root_path
  end
  
  def toggle_activation
    @user = User.find_by_id(params[:id])
    if current_user?(@user) && @user.active?
       @feedback = Feedback.new
       @user = User.find_by_id(params[:id])
       render 'feedback'
    elsif !@user.active?
      render 'reactivate'
    else
      redirect_to root_path
    end
  end
  
  def reactivate
    @user = User.find_by_id(params[:id])
    redirect_to root_path unless @user
    if @user.authenticate(params[:user][:password]) && !@user.active?      
       if @user.toggle!(:deactivated)
          flash[:success] = "You account has been reactivated. Welcome back!"
          sign_in @user
          redirect_to @user
       else
          redirect_to root_path
       end
       #TODO: send reactivation mail
    else
      flash.now[:error] = "The password you have entered is incorrect. Please try again."
      render "reactivate"
    end
  end
  
  def deactivate
    if @user.active?
       @user.toggle!(:deactivated)
       @user.deactivate_user
       sign_out
       flash[:success] = "Your account has been deactivated. Come back soon!"
    end
    redirect_to root_path
  end
  
  def mailfriend
    @user = User.find(params[:id])  
    if params[:email].nil?
      render 'shared/friend_email', :user => @user
    else
      @email = params[:email]
      @note = params[:note]
      #TODO: move emailer to its own thread
      SiteMailer.mail_friend(@email, current_user, @user, @note).deliver
      flash[:success] = "Email recommendation has been sent to your friend!"
      redirect_to @user
    end
  end
  
  def confirm
    @user = User.find(params[:id])
    @token = params[:token]

    if @token.nil?
      redirect_to root_path
    elsif @user.confirm_status?(@token)
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      flash[:error] = "Confirmation failed: #{@user.errors.messages}"
      redirect_to signin_path
    end
  end
  
  def filter
    store_nav_history
    
    if remembered_city.nil? || params[:category].nil?
      redirect_to root_path
    else
      @city = remembered_city
      @country = remembered_country
      @service = Service.find_by_id(params[:category])
      @profiles = @city.hostprofiles.by_service(params[:category])
      @users = []
      @users = @profiles.collect(&:user).paginate(page: params[:page], per_page: 7)
      render 'index'
    end
  end
  
private
    
  def correct_user
    #adding a check for the correct controller since hostprofile update seems to be triggering these before filters
    #possibly due to the 1:1 association.
    if params[:controller]=="users"
       @user=User.find_by_id(params[:id])
       redirect_to(root_path) unless current_user?(@user)
    end
  end
    
  def active_user
     @user = User.find_by_id(params[:id]) 
     if @user && !@user.active?
       flash[:error] = "Sorry, this user is no longer active"
       redirect_to session[:prev]
     end
  end
  
  def admin_user
      redirect_to(root_path) unless current_user.admin? && !current_user?(@user)
  end
  
  def location_specified
    @city = remembered_city
    @country = remembered_country
    if @city.nil? || @country.nil?
      redirect_to root_path
    end
  end
end