class HomeController < ApplicationController

  def index
    @photo = RandomInstagramPhoto.new
    # if @photo.no_location == true
    #   flash[:notice] = "secret location"
    #  end
  end
end
