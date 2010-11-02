class Order < ActiveRecord::Base
  PAYMENT_TYPES = [
    ['現金', 'checkout'], ["クレジットカード", "cc"], ["ネットプロテクション", "np"]
  ]
  has_many :line_items
  accepts_nested_attributes_for :line_items, :allow_destroy => true

  validates_presence_of :name, :address, :email, :pay_type
  validates_inclusion_of :pay_type, :in => PAYMENT_TYPES.map(&:last)

  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      line_item = LineItem.from_cart_item(item)
      line_items << line_item
    end
  end
end
