module Api::V1
  class UnshippedController < ApiController
    def index
      unshipped_items = OrderItem.where(shipped_on: nil)
      data = unshipped_items.map do |oi|
        {
          id: oi.id.to_s,
          type: 'order_item',
          attributes: {
            order_id: oi.order_id,
            order_date: oi.order.date.to_s,
            item: oi.item.name,
            quantity: oi.quantity
          }
        }
      end

      render json: { data: data }
    end
  end
end
