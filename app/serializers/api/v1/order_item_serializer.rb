module Api::V1
  class OrderItemSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :quantity, :order_id, :item_id

    belongs_to :order
    belongs_to :item
  end
end
