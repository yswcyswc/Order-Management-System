module Api::V1
  class UnshippedController < ApiController
    def index
      unshipped_items = OrderItem.where(shipped_on: nil)
      render json: UnshippedOrderItemSerializer.new(unshipped_items)
    end
  end
end
