module Api::V1
  class OrderSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :date, :grand_total

    attribute :address do |order|
      AddressSerializer.new(order.address)
    end
  end
end
