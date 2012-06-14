module LocationsHelper
  def remembered_city
    City.find_by_id(cookies[:city_id])
  end

  def remembered_country
    Country.find_by_id(cookies[:country_id])
  end

  def remember_destination(city_id, country_id)
    cookies[:country_id] = country_id
    cookies[:city_id] = city_id
  end
   
  def clear_destination
    cookies.delete(:country_id)
    cookies.delete(:city_id)
  end
  
  def find_location(loc)
    location = loc.split(",")
    #TODO needs error handling
    city_name = location[0] && location[0].strip
    country_name = location[1] && location[1].strip
    @city = City.find_by_name(city_name)
    @country = Country.find_by_name(country_name)
    if @city.nil? || @country.nil?
      return false
    end 
    return @city.is_city_of(@country)
  end
  
  def location_is_specified
    remembered_city && remembered_country
  end
  
  
end
