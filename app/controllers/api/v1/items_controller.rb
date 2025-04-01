module Api::V1
  class ItemsController < ApiController
    def show
      item = Item.find(params[:id])
      render json: ItemSerializer.new(item)
    end
  end
end
