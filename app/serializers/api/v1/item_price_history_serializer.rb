module Api::V1
  class ItemPriceHistorySerializer
    include FastJsonapi::ObjectSerializer

    set_type :price_history
    attributes :item

    attribute :item do |item|
      item.name
    end

    attribute :prices do |item|
      item.item_prices.map do |price|
        {
          start_date: price.start_date.to_s,
          end_date: price.end_date ? price.end_date.to_s : nil,
          price: "$#{price.price}"
        }
      end
    end
  end
end
