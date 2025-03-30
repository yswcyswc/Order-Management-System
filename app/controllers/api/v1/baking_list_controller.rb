module Api::V1
  class BakingListController < ApiController
    def index
      items = Item.where(active: true)
      baking_list = items.each_with_object({}) do |item, hash|
        quantity = OrderItem.where(item_id: item.id).sum(:quantity)
        hash[item.name] = quantity if quantity > 0
      end

      render json: baking_list
    end
  end
end