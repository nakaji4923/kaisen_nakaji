class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :image_url
  validates_numericality_of :price, :greater_than => 0, :only_integer => true
  validates_format_of :image_url, :with => %r{\.(gif|jpg|jpeg|png)\Z}i,
                      :message => " は GIF,JPG,PNG形式のurlでなくてはいけません" 
end
