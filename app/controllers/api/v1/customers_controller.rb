module Api::V1
  class CustomersController < ApplicationController
    before_action :set_customer, only: [:show]

    def index
      render json: CustomerSerializer.new(Customer.all)
    end

    def show
      render json: CustomerSerializer.new(@customer)
    end

    private

    def set_customer
      @customer = Customer.find(params[:id])
    end
  end
end
