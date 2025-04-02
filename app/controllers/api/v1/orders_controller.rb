# require 'Baking' # not working

module Api
  module V1
    class OrdersController < ApiController
      # include Baking
      def baking_list
        render json: Baking.create_baking_list_for_all
      end

      def unshipped
        unshipped_items = OrderItem.unshipped.alphabetical
        render json: UnshippedOrderItemSerializer.new(unshipped_items)
      end
    end
  end
end
