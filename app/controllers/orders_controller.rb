class OrdersController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @orders = Order.order(:created_at).reverse_order
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    #if @order.update_attributes!(params[:order])  # line_itemにvalidateを追加したから、!マークがいらない。
    if @order.update_attributes(params[:order])
      redirect_to orders_path, :notice => "注文情報を更新しました"
    else
      render :action => "edit"
    end
  end
end
