class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :user_id_verification, only: [:edit, :update, :destroy]
  before_action :sales_status_verification, only: [:edit, :update]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :item_status_id, :shipping_fee_id, :prefecture_id,
                                 :days_to_ship_id, :price, :item_image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def user_id_verification
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def sales_status_verification
    redirect_to root_path if @item.order.present?
  end
end
