# class CartController < ApplicationController
#   before_action :check_login
#   include Cart

#   def view_cart
#     @items_in_cart = get_list_of_items_in_cart
#     @subtotal = calculate_cart_items_cost
#     @shipping_cost = calculate_cart_shipping
#     @total = @subtotal + @shipping_cost
#   end

#   def add_item
#     add_item_to_cart(params[:id])
#     item = Item.find(params[:id])
#     flash[:notice] = "#{item.name} was added to cart."
#     redirect_to items_path
#   end

#   def remove_item
#     remove_item_from_cart(params[:id])
#     item = Item.find(params[:id])
#     flash[:notice] = "#{item.name} was removed from cart."
#     redirect_to view_cart_path
#   end

#   def empty_cart
#     clear_cart
#     flash[:notice] = "Cart is emptied."
#     redirect_to view_cart_path
#   end

#   def checkout
#     @items_in_cart = get_list_of_items_in_cart
#     @subtotal = calculate_cart_items_cost
#     @shipping_cost = calculate_cart_shipping
#     @total = @subtotal + @shipping_cost
#     @addresses = current_user.customer.addresses.active
#     @order = Order.new
#   end
# end
