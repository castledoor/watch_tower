class RandomInstagramPhoto 
  attr_reader :photo, :longitude, :latitude, :url, :geocoder_city, :geocoder_State_or_Country, :geocoder, :data, :location, :format
 
  def initialize
    @photo = Instagram.media_popular.first
    if @photo['location'] 
      @url = @photo['images']['standard_resolution']['url']
      @latitude = @photo['location']['latitude']
      @longitude = @photo['location']['longitude']
    else 
      @url = @photo['images']['standard_resolution']['url']
    end
    # @url = @photo['images']['standard_resolution']['url']
    # @location = @photo['location']
  end

  def geo_code_city
    @geo_code_city = Geocoder.search(format_for_geocode).fifth.data["address_components"].first["long_name"] 
    # @geocoder =  Geocoder.search(coordinates).first.data['address_components'].fourth["long_name"]
    # @geocoder_State_or_Country = @geocoder["address_components"].second["long_name"] 
  end

  def no_location
    if @photo.geo_code_city == nil && @photo.geo_code_state_or_country == nil
      return true
    end
  end

  def geo_code_state_or_country
    @geo_code_state_or_country = Geocoder.search(format_for_geocode).fifth.data["address_components"].second["long_name"] 
  end


  def format_for_geocode
    lat = @photo['location']['latitude']
    long = @photo['location']['longitude']
    lat.to_s + ", " + long.to_s
  end
end

