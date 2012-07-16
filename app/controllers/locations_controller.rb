#TODO: Move all the javascript handling to the javascript controller
class LocationsController < ApplicationController
  
  def index
    @cities = City.order(:name).where("name LIKE ?", "#{params[:term]}%")
    @countries = @cities.map{|c| Country.find_by_id(c.country_id).name}
    render json: @cities.map{|c| "#{c.name}, #{Country.find_by_id(c.country_id).name}"}
  end
  
  def fill_location
    if params[:city_country_location].empty?
      flash[:error] = "Please enter a valid location"
      redirect_to root_path
    else
      if find_location(params[:city_country_location])
        remember_destination(@city.id, @country.id)
        @users = @city.hosts.paginate(page: params[:page], per_page: 7)
        redirect_to users_path 
      else
        flash[:error] = "Sorry, we don't have entries for #{params[:city_country_location]} yet"
        redirect_to users_path
      end     
    end 
  end
  
  
  def show
    
  end
end
