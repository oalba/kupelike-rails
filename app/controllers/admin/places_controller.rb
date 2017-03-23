module Admin
  class PlacesController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource
    def index
      @places = Place.all
    end

    def show
      @place = Place.find(params[:id])
    end

    def new
      @place = Place.new
    end

    def edit
      @place = Place.find(params[:id])
    end

    def create
      # @place = Place.new(params[:place])
      @place = Place.new(place_params)

      if @place.save
        redirect_to admin_places_path
      else
        render 'new'
      end
      # render plain: params[:place].inspect
    end

    def update
      @place = Place.find(params[:id])

      if @place.update(place_params)
        redirect_to admin_place_path(@place)
      else
        render 'edit'
      end
    end

    def destroy
      @place = Place.find(params[:id])
      @place.destroy

      redirect_to admin_places_path
      index
    end

    private

      def place_params
        params.require(:place).permit(:name, :address, :latitude, :longitude, :description, :picture, :town, :time, :phone, :email)
      end
  end
end
