module Api::V1
  class ItemSerializer
    include FastJsonapi::ObjectSerializer

    attributes :name, :description, :category, :units_per_item, :weight

    attribute :current_price do |item|
      ActionController::Base.helpers.number_to_currency(item.current_price)
    end

    attribute :orders_past_7_days do |item|
      recent_orders = item.order_items.joins(:order)
                           .where("orders.date >= ?", 7.days.ago.to_date)

      recent_orders.map do |order_item|
        {
          date: order_item.order.date.to_s,
          customer: "#{order_item.order.customer.last_name}, #{order_item.order.customer.first_name}",
          quantity: order_item.quantity
        }
      end
    end
  end
end