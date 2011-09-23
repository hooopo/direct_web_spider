# encoding: utf-8

class BrandType
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, unique: true
  field :desc
  field :onsale_at, :type => Date

  belongs_to :brand
  has_many :products
end