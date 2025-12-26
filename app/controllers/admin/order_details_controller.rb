class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(making_status: params[:order_detail][:making_status])

    order = order_detail.order

    if order.payment_confirmed? &&
      order.order_details.where(making_status: "making").exists?
      order.update!(status: "in_production")
    end

    redirect_to admin_order_path(order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end

