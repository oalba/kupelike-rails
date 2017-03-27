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
    @items = @place.items.where(place_id: @place.id)
    @votes = Vote.all
    @clients = Client.all
    males = 0
    females = 0
    @item_data = []
    # @item_dates = []
    @items.each do |item|
      @votes.select(:client_id).where(item_id: item.id).each do |vote|
        client = @clients.find(vote.client_id)
        if client.gender == "male"
          males += 1
        elsif client.gender == "female"
          females += 1
        end
      end
      @item_data << { item_id: item.id, males: males, females: females }
      males = 0
      females = 0
      # @item_dates << @votes.group(:date).count
    end
    @item_data
    # puts @item_dates
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
