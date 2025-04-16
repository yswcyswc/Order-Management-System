class OrdersController < ApplicationController
  before_action :check_login
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  authorize_resource

  include Cart

  def index
    @all_orders = Order.chronological.to_a
  end

  def show
    @order_items = @order.order_items.includes(:item)
    @other_orders = @order.customer.orders.where.not(id: @order.id).chronological.to_a
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.date = Date.current
    @order.customer_id ||= current_user&.customer&.id
    @order.update(grand_total: calculate_cart_items_cost + calculate_cart_shipping)

  
    if @order.save
      save_each_item_in_cart(@order)     
      clear_cart
      flash[:notice] = "Thank you for ordering from Roi du Pain."
      
      redirect_to order_path(@order)
    else
      render :new
    end


  end
  


  def edit
  end

  def update
    if @order.update(order_params)
      flash[:notice] = "Order was revised in the system."
      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  def destroy
    if @order.order_items.shipped.empty?
      @order.destroy
      flash[:notice] = "Order was removed from the system."
      redirect_to orders_path
    else
      flash[:error] = "Order cannot be removed from the system because some items have shipped."
      redirect_to order_path(@order)
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_id, :address_id, :grand_total, :expiration_month, :expiration_year, :credit_card_number)
  end
end
