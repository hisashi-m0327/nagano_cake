class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: "商品を登録しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end


  private

  def item_params
    params.require(:item).permit(
      :name,
      :introduction,
      :price,
      :is_active
    )
  end
end
