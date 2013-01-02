class SessionsController < ApplicationController
before_filter :confirmed_user, only: :create
  def destroy
    sign_out
    redirect_to root_path
  end

  def create
    if @user && @user.authenticate(params[:session][:password])
      if @user.active?  
        sign_in @user
        redirect_back_or @user
      else
        redirect_to toggle_activation_user_path(@user)
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
# if user has a non-facebook account, direct them to password sign in
# if the user has a facebook account, log them in and update account information (including email)
# if user is new, create a facebook account
  def facebook_create  
    @auth = env["omniauth.auth"]
    @user = User.find_by_email(@auth.info.email)
    
    #fb user exists, update fb info and log in
    if @user && @user.is_fb_user?
      @user.update_fb_user(@auth)
      sign_in @user
      redirect_back_or @user
      
    #user exists by email but not a fb user, redirect to password login 
    elsif @user
      flash[:error] = "You have already created an account with the email address associated with your Facebook account. Please log in with password." 
      redirect_to signin_path
    
    #user doesn't exist by email
    else
      @user = User.find_by_fb_id(@auth.id)
      #if user is fb user but email is changed, update email and login
      if @user && @user.is_fb_user?
        @user.update_fb_user(@auth)
        sign_in @user
        redirect_back_or @user
        
      
      #create a new fb user
      else
        @user = User.new
        @user.create_fbuser(@auth)
        flash[:success] = "Welcome to tiniHost!"
        sign_in @user
        redirect_back_or @user
        
      end
    end
  end
  
private
  
  def confirmed_user
    @user = User.find_by_email(params[:session][:email])
    unless @user.nil?
      if !@user.confirmed?
        flash.now[:error] = "You must confirm your account first. Look for activation link in your inbox."
        render 'new'
      end
    end 
  end
  
end
