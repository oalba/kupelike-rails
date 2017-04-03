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
      @place = Place.new(place_params)

      if @place.save
        flash[:success] = "Place created successfully."
        redirect_to admin_places_path
      else
        flash[:error] = "Place could not be created."
        render 'new'
      end
    end

    def update
      @place = Place.find(params[:id])

      if @place.update(place_params)
        flash[:success] = "Place updated successfully."
        redirect_to admin_place_path(@place)
      else
        flash[:error] = "Place could not be updated."
        render 'edit'
      end
    end

    def destroy
      @place = Place.find(params[:id])
      if @place.destroy
        flash[:success] = "Place deleted successfully."
      else
        flash[:error] = "Place could not be deleted."
      end
      redirect_to admin_places_path
      # index
    end

    private

      def place_params
        params.require(:place).permit(:name, :address, :latitude, :longitude, :description, :picture, :town, :time, :phone, :email)
      end
  end
end
