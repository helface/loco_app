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
  
  def facebook_create
    @user = User.create_fbuser(env["omniauth.auth"])
    if @user
      flash[:success] = "Welcome to tiniHost!"
      sign_in @user
      redirect_to @user
    else
      flash[:error] = "Sorry, login failed"
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
