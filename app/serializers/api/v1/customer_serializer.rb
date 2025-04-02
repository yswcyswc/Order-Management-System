module Api::V1
  class CustomerSerializer
    include FastJsonapi::ObjectSerializer
    attributes :last_name, :first_name, :email, :phone

    attribute :orders do |customer|
      customer.orders.map do |order|
        OrderSerializer.new(order)
      end
    end
  end
end
