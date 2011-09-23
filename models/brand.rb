# encoding: utf-8

class Brand
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, unique: true
  field :desc
  field :service
  field :brandurl
  field :taobrandurl
  
  has_and_belongs_to_many :top_products
  has_many :products
  has_many :brand_types
end
