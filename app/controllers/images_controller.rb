class ImagesController < ApplicationController
  def new
      @image = current_user.images.build
  end

  def create
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
