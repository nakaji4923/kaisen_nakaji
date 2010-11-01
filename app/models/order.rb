class Order < ActiveRecord::Base
  has_many :line_items
  PAYMENT_TYPES = [
    ['現金', 'checkout'], ["クレジットカード", "cc"], ["ネットプロテクション", "np"]
  ]

  validates_presence_of :name, :address, :email, :pay_type
  validates_inclusion_of :pay_type, :in => PAYMENT_TYPES.map(&:last)

  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      line_item = LineItem.from_cart_item(item)
      line_items << line_item
    end
  end
end
