module Api::V1
  class CustomersController < ApplicationController
    include Actionable
    include Filterable
    filtering_params = %w[active alphabetical]
    before_action :set_customer, only: [:show]

    def index
      @customer = Customer.all
      if(params[:active].present?)
        @customer = params[:active] == "true" ? @customer.active : @customer.inactive
      end
      if params[:alphabetical].present? && params[:alphabetical] == "true"
        @customer = @customer.alphabetical
      end

      # @customer = Customer.all
      # @customer
      render json: CustomerSerializer.new(@customer)
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
