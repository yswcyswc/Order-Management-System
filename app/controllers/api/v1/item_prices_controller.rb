module Api::V1
  class ItemPricesController < ApiController
    def show
      item = Item.find(params[:id])
      render json: { data: price_history_data(item) }
    end

    private

    def price_history_data(item)
      {
        id: item.id.to_s,
        type: 'price_history',
        attributes: {
          item: item.name,
          prices: item.item_prices.order(:start_date).map { |p| format_price_record(p) }
        }
      }
    end

    def format_price_record(record)
      {
        start_date: record.start_date.to_s,
        end_date: record.end_date&.to_s,
        price: format_price(record.price)
      }
    end

    def format_price(amount)
      sprintf("$%.2f", amount)
    end
  end
end