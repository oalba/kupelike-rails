module Admin
  class ItemsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    # def show
    #   @place = Place.find(params[:place_id])
    #   @item = @place.items.find(params[:id])
    # end

    def new
      @place = Place.find(params[:place_id])
      @item = @place.items.build
    end

    def edit
      @place = Place.find(params[:place_id])
      @item = @place.items.find(params[:id])
    end

    def create
      # @item = Item.new(params[:item])
      @place = Place.find(params[:place_id])
      @item = @place.items.build(item_params)
      @item.votes = 0
      @item.save
      redirect_to admin_place_path(@place)
    end

    def update
      @place = Place.find(params[:place_id])
      @item = @place.items.find(params[:id])
      @item.update(item_params)
      redirect_to admin_place_path(@place)
    end

    def destroy
      @place = Place.find(params[:place_id])
      @item = @place.items.delete(params[:id])
      # @item.destroy
      redirect_to admin_place_path(@place)
    end

    private

      def item_params
        params.require(:item).permit(:name, :description, :picture, :year, :place_id, :votes)
      end
  end
end
