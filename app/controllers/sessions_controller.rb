class SessionsController < ApplicationController
before_filter :confirmed_user, only: :create
  def destroy
    sign_out
    redirect_to root_path
  end

  def create
    if @user && @user.authenticate(params[:session][:password])
      #sign user into profile
      sign_in @user
      redirect_back_or @user
    else
      #error message
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  private
  
  def confirmed_user
    @user = User.find_by_email(params[:session][:email])
    unless @user.confirmed?
      flash.now[:error] = "You must confirm your account first. Look for activation link in your inbox."
      render 'new'
    end 
  end
  
end
