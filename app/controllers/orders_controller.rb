class OrdersController < ApplicationController
  before_action :check_login
  before_action :set_order, only: [:show]
  authorize_resource only: [:index] 

  def index
    @orders = current_user.customer.orders if current_user.customer_role?
    @orders ||= Order.all
  end

  def show
    authorize! :show, @order
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
