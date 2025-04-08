class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def edit
  end

  def update
    if @order_item.update(order_item_params)
      flash[:notice] = "Order items were revised in the system."
      redirect_to order_path(@order_item.order)
    else
      render action: 'edit'
    end
  end

  def destroy
    item_name = @order_item.item.name
    if @order_item.shipped_on.nil?
      @order_item.destroy
      flash[:notice] = "#{item_name} was removed from this order."
    end
    redirect_to order_path(@order_item.order)
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :quantity, :shipped_on)
  end
end
