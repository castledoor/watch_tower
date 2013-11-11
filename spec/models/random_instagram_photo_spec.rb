require 'spec_helper'

describe RandomInstagramPhoto do
  it "returns a random instagram photo with location", :vcr do
    VCR.use_cassette "popular/photo" do
      Instagram.media_popular.first
      photo = RandomInstagramPhoto.new
      photo.url.should eq "http://distilleryimage4.s3.amazonaws.com/6226f126497711e3902c12d79b6bbe90_8.jpg"
    end
  end

  it "returns a random instagram photo without location" , :vcr do
     VCR.use_cassette "popular/location_check" do
      Instagram.media_popular.first
      photo = RandomInstagramPhoto.new
      photo.url.should eq "http://distilleryimage7.s3.amazonaws.com/008bbb44497311e38f1a125ddbfa3836_8.jpg"
    end
  end


  it "returns the latitude of a photo", :vcr do
    VCR.use_cassette "popular/photo_with_coords" do
      Instagram.media_popular.first
      photo = RandomInstagramPhoto.new
      photo.latitude.should eq 43.647717893
    end
  end

  it "returns the longitude of a photo", :vcr  do
    VCR.use_cassette "popular/photo_with_coords" do
      Instagram.media_popular.first
      photo = RandomInstagramPhoto.new
      photo.longitude.should eq -79.376069653
    end
  end
  

   it "returns coordinates in a nice format for geo_code", :vcr  do
    VCR.use_cassette "popular/photo_with_coords" do
      Instagram.media_popular.first
      photo = RandomInstagramPhoto.new
      photo.format_for_geocode.should eq "43.647717893, -79.376069653"
    end
  end

it "returns a random photo even when the location is nil" , :vcr  do
    VCR.use_cassette "popular/location_check" do
      Instagram.media_popular.first
      photo = RandomInstagramPhoto.new
      photo.no_location.should eq true
    end
  end



  it "returns a city" , :vcr  do
    VCR.use_cassette "popular/photo_with_coords" do
      Instagram.media_popular.first
      photo = RandomInstagramPhoto.new

      VCR.use_cassette('geocoder/city', :record => :new_episodes)  do
        Geocoder.search("34.146427643, -118.126226273").fifth.data['address_components'].first["long_name"]
        photo.geo_code_city.should eq "M5E"
      end
    end
  end
    


  it "returns a state or country" , :vcr  do
    VCR.use_cassette "popular/photo_with_coords" do
      Instagram.media_popular.first
      photo = RandomInstagramPhoto.new

      VCR.use_cassette('geocoder/city', :record => :new_episodes)  do
        Geocoder.search('34.146427643, -118.126226273').fifth.data['address_components'].second["long_name"]
        photo.geo_code_state_or_country.should eq "Toronto"
      end
    end
  end
end 

