class ItemPricesController < ApplicationController
  before_action :check_login
  authorize_resource

  def new
    @item_price = ItemPrice.new
  end

  def create
    @item_price = ItemPrice.new(item_price_params)

    if @item_price.save
      newp = ActionController::Base.helpers.number_to_currency(@item_price.price)
      flash[:notice] = "New price of #{@item_price.item.name} is #{newp}."
      redirect_to item_path(@item_price.item)
    else
      render :new
    end
  end

  private

  def item_price_params
    params.require(:item_price).permit(:item_id, :price)
  end
end
