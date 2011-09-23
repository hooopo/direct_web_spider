# coding: utf-8
class Product
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  
  scope :from_kind, ->(kind){where(:kind => kind)}

  field :price, :type => BigDecimal, :precision => 10, :scale => 2
  field :price_url, :type => String
  field :title, :type => String
  field :stock, :type => Integer
  field :kind, :type  => String
  field :image_url, :type => String
  field :desc, :type => String
  field :image_info, :type => Array
  field :score, :type => Integer
  field :standard, :type => String
  field :product_code, :type => String
  field :product_url_id, :type => BSON::ObjectId

  belongs_to :product_url

  belongs_to :merchant
  belongs_to :brand
  belongs_to :end_product
  belongs_to :brand_type

  embeds_many :comments
    
end
