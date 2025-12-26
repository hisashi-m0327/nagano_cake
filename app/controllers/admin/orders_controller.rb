class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.includes(:customer, :order_details).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)

    if @order.status == "payment_confirmed"
      @order.order_details.update_all(making_status: "waiting")
    end

    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
