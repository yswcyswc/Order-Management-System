module Api::V1
  class CustomerSerializer
    include FastJsonapi::ObjectSerializer
    attributes :first_name, :last_name, :email, :phone

    attribute :orders do |customer|
      customer.orders.map do |order|
        OrderSerializer.new(order)
      end
    end
  end
end
