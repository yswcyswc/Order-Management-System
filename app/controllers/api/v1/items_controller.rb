module Api::V1
  class ItemsController < ApiController
    def show
      item = Item.find(params[:id])
      render json: { data: item_data(item) }
    end

    private
    def format_order(order_item)
      {
        date: order_item.order.date.to_s,
        customer: "#{order_item.order.customer.last_name}, #{order_item.order.customer.first_name}",
        quantity: order_item.quantity
      }
    end
    
    def recent_orders(item)
      OrderItem.joins(:order, :item)
               .where(item_id: item.id)
               .where("orders.date >= ?", 7.days.ago.to_date)
               .map { |o| format_order(o) }
    end

    def item_data(item)
      {
        id: item.id.to_s,
        type: 'item',
        attributes: {
          name: item.name,
          description: item.description,
          category: item.category,
          units_per_item: item.units_per_item,
          weight: item.weight,
          current_price: item.current_price&.to_s || "N/A",
          orders_past_7_days: recent_orders(item)
        }
      }
    end
  end
end