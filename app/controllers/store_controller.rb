class StoreController < ApplicationController
  before_filter :set_cart

  def index
    @products = Product.for_sale.paginate :page => params[:page], :per_page => 3
  end

  def save_order
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    if @order.save
      @cart.empty!
      redirect_to store_path, :notice => "ご注文ありがとうございます"
    else
      render checkout_path
    end
  end

  def checkout
    if @cart.nil? || @cart.items.empty?
      redirect_to store_path, :notice => "カートは現在空です"
    end

    @order = Order.new
  end

  def add_to_cart
    #@product = Product.find(params[:id])
    product = Product.find(params[:id])
    @cart.add_product(product)
    #redirect_to store_path, :notice => "#{@product.name}が買い物カゴに追加されました"
    respond_to do |format|
      format.js
    end
  rescue ActiveRecord::RecordNotFound
    logger.error("無効な商品#{params[:id]}にアクセスしようとしました")
    redirect_to store_path, :notice => "無効な商品です"
  end

  def empty_cart
    @cart.empty!
    redirect_to store_path, :notice => "カートは現在空です"
  end

  private
  def current_cart
    session[:cart] ||= Cart.new

#    if session[:cart].nil?
#      Cart.new
#    else
#      session[:cart]
#    end

  end

  def set_cart
    @cart = current_cart
  end
end
