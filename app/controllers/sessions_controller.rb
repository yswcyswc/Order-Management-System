class SessionsController < ApplicationController
  include Cart

  def new
  end

  def create 
    user = User.authenticate(params[:username], params[:password])
    if user && user.active
      session[:user_id] = user.id

      if user.role == "customer"
        create_cart
      end

      redirect_to home_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Username and/or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    destroy_cart
    redirect_to home_path, notice: "Logged out!"
  end
  
end