class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]
  before_action :check_login, only: [:index, :show, :edit, :update]
  authorize_resource
  include Cart

  def index
    @active_customers = Customer.active.alphabetical.to_a
    @inactive_customers = Customer.inactive.alphabetical.to_a
  end

  def new
    @customer = Customer.new
  end

  def show
    @customer = Customer.find(params[:id])
    @previous_orders = @customer.orders.chronological.to_a
    @addresses = @customer.addresses
  end


  def edit
  end


  def create
    @customer = Customer.new(customer_params)
    @customer.user.role = "customer" if @customer.user.present?
  
    if @customer.save
      session[:user_id] = @customer.user.id
      create_cart
      flash[:notice] = "Welcome to Roi du Pain -- We hope you enjoy shopping with us."
      redirect_to customer_path(@customer)
    else
      render action: 'new'
    end
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "#{@customer.proper_name} was revised in the system."
      redirect_to customer_path(@customer)
    else
      render action: 'edit'
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :first_name, :last_name, :email, :phone, :active,
      user_attributes: [:username, :password, :password_confirmation, :role]
    )
  end

  # def user_params
  #   params.require(:customer).permit(:username, :password, :password_confirmation)
  # end  

end