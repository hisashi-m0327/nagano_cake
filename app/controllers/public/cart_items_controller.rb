class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.includes(:item)
    @total = @cart_items.sum(&:subtotal)
  end

  def create
    cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])

    if cart_item
      # すでに存在する場合は数量を加算
      cart_item.amount += params[:amount].to_i
      cart_item.save
    else
      # 新規追加
      cart_item = current_customer.cart_items.new(cart_item_params)
      cart_item.save
    end

    redirect_to public_cart_items_path
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.update(amount: params[:cart_item][:amount])

    redirect_to public_cart_items_path
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.destroy

    redirect_to public_cart_items_path
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path, notice: "カートを空にしました"
  end

  private

  def cart_item_params
    params.permit(:item_id, :amount)
  end

  
end
