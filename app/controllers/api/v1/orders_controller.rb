module Api
  module V1
    class OrdersController < ApiController
      def baking_list
        items = Item.where(active: true)
        baking_list = {}

        items.each do |item|
          quantity = OrderItem.where(item_id: item.id).sum(:quantity)
          baking_list[item.name] = quantity if quantity.positive?
        end

        render json: baking_list
      end

      def unshipped
        unshipped_items = OrderItem.where(shipped_on: nil)
        render json: UnshippedOrderItemSerializer.new(unshipped_items)
      end
    end
  end
end
