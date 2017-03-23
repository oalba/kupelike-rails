class PlacesController < ApplicationController
  # before_filter :authenticate_user!
  # load_and_authorize_resource
  def index
    @places = Place.all
  end

  def maps
    @places = Place.all
    render 'all_maps'
  end

  def map
    @place = Place.find(params[:id])
  end

  def show
    @place = Place.find(params[:id])
  end

  def search
    @places = Place.all
    if params[:search]
      @places = Place.search(params[:search]).order('name asc')
    else
      @places = Place.all.order('name asc')
    end
    render json: @places
  end
end
