class ImagesController < ApplicationController
  def new
      @image = current_user.images.build
  end

  def create
      if current_user.images.count == 7
        flash[:error] = "Sorry, you have reached the maximum number of allowed pictures. Please delete old pictures to make room for new ones."
        redirect_to new_image_path
        return
      end
      @image = current_user.images.build(params[:image])
      if @image.save
        flash[:success] = "your image has been uploaded"
        redirect_to current_user
      else
        flash[:error] = "Sorry, we were not able to upload your picture"
        redirect_to current_user
      end
  end

  def destroy
    @img = Image.find(params[:id])
    @img.destroy
    @img.clear_photo
    redirect_to current_user
  end
end
