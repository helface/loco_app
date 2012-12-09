class ImagesController < ApplicationController
  def new
      @image = current_user.images.build
  end

  def create
      @user = current_user
      if @user.at_max_picture?
        flash[:error] = "Sorry, you have reached the maximum number of allowed pictures. Please delete old pictures to make room for new ones."
        redirect_to edit_user_path(@user, :view => "picture")
        return
      end
      @image = @user.images.build(params[:image])
      if @image.save
        #set default profile picture
        if @image == @user.images.first
          @user.update_attributes(:profile_pic_id => @image.id)
          sign_in @user
        end
        #redirect_to session[:prev]
        render :action => 'crop', img: @image
      else
        flash[:error] = "Sorry, we were not able to upload your picture #{@image.errors.full_messages}"
        redirect_to edit_user_path(@user, :view => "picture")
      end
  end
  
  def show
    @img = Image.find_by_id(params[:id])
  end
  
  def update
    @image = Image.find(params[:id])
    
    if @image.update_attributes(params[:image])   
      @image.reprocess 
      flash[:success] = "your image has been uploaded"
      redirect_to session[:prev]
    end
  end

  def destroy
    @img = Image.find(params[:id])
    user = User.find_by_id(@img.user_id)
    if user.profile_pic_id == @img.id
      user.profile_pic_id = nil
    end
    @img.destroy
    @img.clear_photo
    user.set_default_profile_pic
    user.save
    sign_in user
    redirect_to session[:prev]
  end
end
