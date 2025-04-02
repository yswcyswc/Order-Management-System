module Api::V1
  class CustomerSerializer
    include FastJsonapi::ObjectSerializer
    attributes :last_name, :first_name, :email
    attribute :phone do |object|
      ActionController::Base.helpers.number_to_phone(object.phone)
    end 

    attribute :orders do |customer|
      customer.orders.map do |order|
        OrderSerializer.new(order)
      end
    end
  end
end
