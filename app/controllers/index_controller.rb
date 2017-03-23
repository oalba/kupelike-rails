class IndexController < ApplicationController
  def index
    @places = Place.all
  end
end
