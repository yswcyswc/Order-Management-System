module Contexts
  module Orders
    # Context for orders (assumes customer, user, address context)
    def create_orders
      @alexe_o1   = FactoryBot.create(:order, customer: @alexe, address: @alexe_a2, grand_total: 5.25, date: 5.days.ago.to_date)
      @alexe_o1.pay
      @alexe_o1.update_attribute(:date, 5.days.ago.to_date)
      @alexe_o2   = FactoryBot.create(:order, customer: @alexe, address: @alexe_a2, grand_total: 5.25, date: 3.days.ago.to_date)
      # @alexe_o2.pay
      @alexe_o2.update_attribute(:date, 3.days.ago.to_date)
      @alexe_o3   = FactoryBot.create(:order, customer: @alexe, address: @alexe_a1, grand_total: 22.50, payment_receipt: nil, date: Date.current)
      @melanie_o1 = FactoryBot.create(:order, customer: @melanie, address: @melanie_a1, grand_total: 5.50, date: 4.days.ago.to_date)
      @melanie_o1.pay
      @melanie_o2 = FactoryBot.create(:order, customer: @melanie, address: @melanie_a1, grand_total: 5.50, payment_receipt: nil, date: Date.current)
      @anthony_o1 = FactoryBot.create(:order, customer: @anthony, address: @anthony_a1, grand_total: 16.50, date: Date.current)
      @anthony_o1.pay
      @ryan_o1    = FactoryBot.create(:order, customer: @ryan, address: @ryan_a1, grand_total: 11, payment_receipt: nil, date: Date.current)
    end

    def create_additional_orders_and_items
      @ryan_o2    = FactoryBot.create(:order, customer: @ryan, address: @ryan_a1, grand_total: 137.55, payment_receipt: nil, date: Date.current)
      @ryan_o2.pay
      @ryan_o2_i1 = FactoryBot.create(:order_item, order: @ryan_o2, item: @challah, quantity: 2, shipped_on: nil)
      @ryan_o2_i2 = FactoryBot.create(:order_item, order: @ryan_o2, item: @blueberry, quantity: 4, shipped_on: nil)
      @ryan_o2_i3 = FactoryBot.create(:order_item, order: @ryan_o2, item: @sourdough, quantity: 5, shipped_on: nil)
      @ryan_o2_i4 = FactoryBot.create(:order_item, order: @ryan_o2, item: @honey_wheat, quantity: 9, shipped_on: nil)
      @ryan_o2_i5 = FactoryBot.create(:order_item, order: @ryan_o2, item: @croissants, quantity: 1, shipped_on: nil)

    end

  end
end