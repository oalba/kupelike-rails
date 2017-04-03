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
      @item.votes_count = 0
      @item.save
      if @item.save
        flash[:success] = "Item created successfully."
        redirect_to admin_place_path(@place)
      else
        flash[:error] = "Item could not be created."
        render 'new'
      end
    end

    def update
      @place = Place.find(params[:place_id])
      @item = @place.items.find(params[:id])

      if @item.update(item_params)
        flash[:success] = "Item updated successfully."
        redirect_to admin_place_path(@place)
      else
        flash[:error] = "Item could not be updated."
        render 'edit'
      end
    end

    def destroy
      @place = Place.find(params[:place_id])
      # @item = @place.items.delete(params[:id])
      if @place.items.delete(params[:id])
        flash[:success] = "Item deleted successfully."
      else
        flash[:error] = "Item could not be deleted."
      end
      # @item.destroy
      redirect_to admin_place_path(@place)
    end

    def update_year
      @place = Place.find(params[:place_id])
      @item = @place.items.find(params[:item_id])
      @votes = Vote.select(:client_id).where(item_id: @item.id, aviso: true)
      @clients = []
      @votes.each do |vote|
        @clients << Client.find(vote.client_id)
      end

      @clients.each do |client|
        MessageMailer.send_aviso(client, @item, @place).deliver
      end
      Vote.where(item_id: @item.id).update_all(aviso: false)
      @item.increment!("year", 1)
      redirect_to admin_place_path(@place)
    end

    private

      def item_params
        params.require(:item).permit(:name, :description, :picture, :year, :place_id, :votes_count)
      end
  end
end
