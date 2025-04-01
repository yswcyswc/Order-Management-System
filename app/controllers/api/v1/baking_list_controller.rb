module Api::V1
  class BakingListController < ApiController
    def index
      items = Item.where(active: true)
      baking_list = {}

      items.each do |item|
        quantity = OrderItem.where(item_id: item.id).sum(:quantity)
        if quantity > 0
          baking_list[item.name] = quantity
        end
      end

      render json: baking_list
    end
  end
end
