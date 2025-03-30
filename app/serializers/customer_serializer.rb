class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  set_type :customer
  attributes :first_name, :last_name, :email, :phone
  attribute :orders do |customer|
    customer.orders.map do |order|
      {
        id: order.id.to_s,
        type: 'order',
        attributes: {
          date: order.date,
          number_of_items: order.order_items.sum(:quantity),
          grand_total: sprintf("$%.2f", order.grand_total),
          address: {
            data: {
              id: order.address.id.to_s,
              type: 'address',
              attributes: {
                recipient: order.address.recipient,
                street_1: order.address.street_1,
                street_2: order.address.street_2,
                city: order.address.city,
                state: order.address.state,
                zip: order.address.zip
              }
            }
          }
        }
      }
    end
  end
end
