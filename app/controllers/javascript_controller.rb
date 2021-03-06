class JavascriptController < ApplicationController
  
  def autofill_location
    @cities = City.order(:name).where("name LIKE ?", "#{params[:term]}%")
    @countries = @cities.map{|c| Country.find_by_id(c.country_id).name}
    render json: @cities.map{|c| "#{c.name}, #{Country.find_by_id(c.country_id).name}"}
  end
  
  def prefill_languages(langs)
    render json: langs.map{|l| Language.find_by_id(l)}
  end
  
end
