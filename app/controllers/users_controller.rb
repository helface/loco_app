class UsersController < ApplicationController
#TODO: correct signup email configuration
#TODO: user friendly URL to hide user id. Use to_param or something similar
respond_to :html, :json
before_filter :signed_in_user, only: [:edit, :update, :destroy, :recommend, :update_profile_pic]    
before_filter :correct_user, only: [:edit, :update, :update_profile_pic]
before_filter :location_specified, only: :index
#TODO: figure out why this is being called for hostprofile destroy
#before_filter :admin_user, only: :destroy
    
  # GET /users
  # GET /users.json
  def index  
      store_nav_history
      @users = @city.hosts.paginate(page: params[:page], per_page: 7)

      #respond_to do |format|
      #format.html # index.html.erb
      #format.json { render json: @users }
      #end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    session[:form_step] = session[:form_params] = nil
    @user = User.find(params[:id])
    @token = params[:token]  
    @reviews = @user.inverse_reviews.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
      #respond_to do |format|
      #format.html # new.html.erb
      #format.json { render json: @user }
      #end
  end

  # GET /users/1/edit
  def edit
    @hostprofile = @user.hostprofile
    @image = Image.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if @user.save
        debugger
        
        flash[:success] = "Congratulations! A confirmation email has been sent to your inbox for activation."
        SiteMailer.signup_confirmation(@user).deliver
        redirect_to signin_path
    else
        render 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update   
     if params[:controller] == 'users'
        @user = User.find_by_id(params[:id])
        if params[:user][:old_password]
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
           respond_with @user, location: user_path(@user)
        else
           flash.now[:error] = "failed to update profile"
           render 'edit'
        end
     end
  end

  def update_profile_pic
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(:profile_pic_id => params[:img_id])
      flash[:success] = "Profile picture successfully updated"
      debugger
      sign_in @user
      redirect_to edit_user_path(@user)
    end
  end
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
      # respond_to do |format|
      #format.html { redirect_to users_url }
      #format.json { head :no_content }
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
      flash[:error] = "Confirmation failed"
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
    
  def admin_user
      redirect_to(root_path) unless current_user.admin? && !current_user?(@user)
  end
  
  #TODO: this code might need a bit of refactoring
  def location_specified
    @city = remembered_city
    @country = remembered_country
    if @city.nil? || @country.nil?
      redirect_to root_path
    end
  end
end