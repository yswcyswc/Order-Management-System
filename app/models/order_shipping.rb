module OrderShipping
  extend ActiveSupport::Concern

  class_methods do
    def not_shipped
      # joins(:order_items).where("order_items.shipped_on IS NULL").to_a.uniq
      joins(:order_items).where("order_items.shipped_on IS NULL").distinct
    end
  end

  included do
    def shipping_costs
      Shipping.calculate_shipping_costs(self.total_weight, allowed = 5, base_rate = 2.00, increment_rate = 0.25)
    end

    def unshipped_items
      self.order_items.unshipped
    end

    def total_weight
      weight = self.order_items.inject(0){|sum, oi| sum += oi.item.weight * oi.quantity}
    end
  end
end