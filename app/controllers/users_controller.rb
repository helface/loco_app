class UsersController < ApplicationController
#TODO: send confirmation email upon signup
before_filter :signed_in_user, only: [:edit, :update, :destroy, :recommend]    
before_filter :correct_user, only: [:edit, :update]
#TODO: figure out why this is being called for hostprofile destroy
#before_filter :admin_user, only: :destroy
    
  # GET /users
  # GET /users.json
  def index
      @users = User.paginate(page: params[:page], per_page: 7)

      #respond_to do |format|
      #format.html # index.html.erb
      #format.json { render json: @users }
      #end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @token = params[:token]  
     
    #for first time confirmation from confirmation email
    confirm_user unless @token.nil?
    @reviews = @user.inverse_reviews.paginate(page: params[:page], per_page: 5)
      #respond_to do |format|
      #format.html  show.html.erb
      #format.json { render json: @user }
      #end
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
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

      #respond_to do |format|
      #if @user.save
      # format.html { redirect_to @user, notice: 'User was successfully created.' }
      # format.json { render json: @user, status: :created, location: @user }
      #else
      # format.html { render action: "new" }
      # format.json { render json: @user.errors, status: :unprocessable_entity }
        #render 'new'
      #end
      #end
    if @user.save
        flash[:success] = "Congratulations! A confirmation email has been sent to your inbox for activation."
        #sign_in @user 
        SiteMailer.signup_confirmation(@user).deliver
        redirect_to signin_path
    else
        render 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    
    if @user.update_attributes(params[:user])
      debugger
        flash[:success] = "Profile successfully updated"
        sign_in @user
        redirect_to @user
    else
        render 'edit'
    end

      #respond_to do |format|
      #if @user.update_attributes(params[:user])
      # format.html { redirect_to @user, notice: 'User was successfully updated.' }
      # format.json { head :no_content }
      #else
      # format.html { render action: "edit" }
      # format.json { render json: @user.errors, status: :unprocessable_entity }
      #end
      #end
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
  
  def recommend
    @user = User.find(params[:id])
    if params[:email].nil?
      render 'shared/friend_email', :user => @user
    else
      @email = params[:email]
      @note = params[:note]
      #TODO: move this to its own thread
      SiteMailer.mail_recommendation(@email, current_user, @user, @note).deliver
      flash[:success] = "Email recommendation has been sent to your friend!"
      redirect_to @user
    end
  end
    
private
    
    def correct_user
        @user=User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
        redirect_to(root_path) unless current_user.admin? && !current_user?(@user)
    end
    
    def confirm_user 
      if @token == @user.confirmation_token
        @user.toggle!(:confirmed)
        sign_in @user
        flash[:success] = "Welcome!"
        redirect_to @user
      else
        flash[:error] = "Confirmation failed"
        redirect_to signin_path
      end
    end
end