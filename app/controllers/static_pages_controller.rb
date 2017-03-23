class StaticPagesController < ApplicationController
  def contact
    @places = Place.all
  end

  def about_us
    @places = Place.all
  end
end
