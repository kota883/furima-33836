class ItemsController < ApplicationController
  
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    elsif
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :item_status_id, :shipping_fee_id, :prefecture_id, :days_to_ship_id, :price, :item_image).merge(user_id: current_user.id)
  end
end
