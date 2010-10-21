class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :image_url
  validates_numericality_of :price, :greater_than => 0, :only_integer => true
  validates_format_of :image_url, :with => %r{\.(gif|jpg|jpeg|png)\Z}i,
                      :message => " は GIF,JPG,PNG形式のurlでなくてはいけません" 
  scope :for_sale, :order => "created_at DESC"
  scope :name_like, lambda {|q| {:conditions => ['name like ?', "%#{q}%"]}}
  scope :recent, lambda {|x| {:limit => x, :order => "created_at DESC"}} 

end
