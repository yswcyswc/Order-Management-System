class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def index
    @active_addresses = Address.active.by_recipient
    @inactive_addresses = Address.inactive.by_recipient
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.customer_id.nil? && current_user.customer_role?
      @address.customer_id = current_user.customer.id
    end

    if @address.save
      flash[:notice] = "Address was added for customer #{@address.customer.proper_name}."
      redirect_to customer_path(@address.customer)
    else
      render action: 'new'
    end
  end

  def show
    @other_addresses = @address.customer.addresses.where.not(id: @address.id).active.to_a
  end

  def edit
  end

  def update
    if @address.update(address_params)
      flash[:notice] = "Address was updated."
      redirect_to customer_path(@address.customer)
    else
      render action: 'edit'
    end
  end

  def destroy
    if @address.orders.empty?
      @address.destroy
      flash[:notice] = "Address was removed from the system."
    else
      flash[:error] = "Address has been used for prior orders and cannot be deleted."
    end
    redirect_to customer_path(@address.customer)
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:recipient, :street_1, :street_2, :city, :state, :zip, :is_billing, :active, :customer_id)
  end
end
