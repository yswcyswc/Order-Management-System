module Api::V1
  class OrderSerializer
    include FastJsonapi::ObjectSerializer
    attributes :date
    attribute :grand_total do |object|
      ActionController::Base.helpers.number_to_currency(object.grand_total)
    end 

    attribute :number_of_items do |order|
      order.order_items.sum(:quantity)
    end

    attribute :address do |order|
      AddressSerializer.new(order.address)
    end

    
  end
end
