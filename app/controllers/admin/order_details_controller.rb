class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update!(order_detail_params)

    order = order_detail.order

    # ① 製作中が1つでもあれば → 製作中
    if order.order_details.where(making_status: "making").exists?
      order.update!(status: "in_production")

    # ② 全て製作完了なら → 発送準備中
    elsif order.order_details.all?(&:finished?)
      order.update!(status: "preparing_shipment")
    end

    redirect_to admin_order_path(order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end

