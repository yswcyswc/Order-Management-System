module Api::V1
  class CustomersController < ApiController
    def index
      customers = Customer.includes(orders: { address: {} }).all
      render json: CustomerSerializer.new(customers).serializable_hash, status: :ok
    end

    def show
      customer = Customer.includes(orders: { address: {} }).find(params[:id])
      render json: CustomerSerializer.new(customer).serializable_hash, status: :ok
    end
  end
end