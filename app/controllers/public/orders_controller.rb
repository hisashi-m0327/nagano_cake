class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.includes(:item)

    case params[:order][:address_option]
    when "own"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = "#{current_customer.last_name} #{current_customer.first_name}"

    when "registered"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address     = address.address
      @order.name        = address.name

    when "new"
  end

  @total_price = @cart_items.sum(&:subtotal)
  @order.postage = 800
  @order.billing_amount = @total_price + @order.postage
end


  def create
    @order = current_customer.orders.new(order_params)

    cart_items = current_customer.cart_items

    total = current_customer.cart_items.sum(&:subtotal)

    @order.postage = 800

    @order.billing_amount = total + @order.postage

    if @order.save
      current_customer.cart_items.each do |cart_item|
        OrderDetail.create!(order: @order, item: cart_item.item, price: cart_item.item.price_with_tax, amount: cart_item.amount)
      end
      current_customer.cart_items.destroy_all

      redirect_to public_order_path(@order)
    else
      render :confirm
    end
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
