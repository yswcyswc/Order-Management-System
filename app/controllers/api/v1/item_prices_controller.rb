module Api::V1
  class ItemPricesController < ApiController
    def show
      item = Item.find(params[:id])
      render json: ItemPriceHistorySerializer.new(item)
    end
  end
end
