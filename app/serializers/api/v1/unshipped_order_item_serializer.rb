module Api::V1
  class UnshippedOrderItemSerializer
    include FastJsonapi::ObjectSerializer

    set_type :order_item
    attribute :order_id

    attribute :order_date do |order_item|
      order_item.order.date.to_s
    end

    attribute :item do |order_item|
      order_item.item.name
    end

    attribute :quantity
  end
end
