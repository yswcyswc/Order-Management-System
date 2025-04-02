module Api::V1
  class OrderSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :date, :grand_total

    attribute :number_of_items do |order|
      order.order_items.sum(:quantity)
    end

    attribute :address do |order|
      AddressSerializer.new(order.address)
    end

    
  end
end
