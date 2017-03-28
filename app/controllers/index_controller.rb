class IndexController < ApplicationController
  def index
    @places = Place.all
  end

  def gps
    @places = Place.all
  end
end
