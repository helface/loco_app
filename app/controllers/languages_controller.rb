class LanguagesController < ApplicationController
  respond_to :html, :json
  
  def index
     @languages = Language.order(:name)
     respond_to do |format|  
       format.html
       format.json {render json: @languages.where("lower(name) LIKE ?", "%#{params[:q]}%")}
     end
  end
  
end
