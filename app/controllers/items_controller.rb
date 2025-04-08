class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @breads = Item.active.where(category: :breads).alphabetical.to_a
    @muffins = Item.active.where(category: :muffins).alphabetical.to_a
    @pastries = Item.active.where(category: :pastries).alphabetical.to_a
    @inactive_items = Item.inactive.alphabetical.to_a if current_user.role != 'customer'
  end

  def show
    @similar_items = Item.active.where(category: @item.category).where.not(id: @item.id).alphabetical.to_a
    @price_history = @item.item_prices.chronological.to_a if current_user.role != 'customer'
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "#{@item.name} was added to the system."
      redirect_to item_path(@item)
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "#{@item.name} was revised in the system."
      redirect_to item_path(@item)
    else
      render action: 'edit'
    end
  end

  def destroy
    if @item.order_items.shipped.empty?
      @item.destroy
      flash[:notice] = "#{@item.name} was removed from the system."
      redirect_to items_path
    else
      flash[:error] = "#{@item.name} has been used for prior orders and cannot be deleted."
      redirect_to item_path(@item)
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :category, :units_per_item, :weight, :active)
  end
end
