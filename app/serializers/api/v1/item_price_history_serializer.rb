module Api::V1
  class ItemPriceHistorySerializer
    include FastJsonapi::ObjectSerializer

    set_type :price_history
    attributes :name

    attribute :prices do |item|
      item.item_prices.map do |price|
        {
          price: price.price.to_s,
          start_date: price.start_date.to_s,
          end_date: price.end_date&.to_s || "N/A"
        }
      end
    end
  end
end
