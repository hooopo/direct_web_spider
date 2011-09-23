# encoding: utf-8

class Merchant
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, unique: true

  field :desc
  field :service

  field :merchanturl
  has_many :products
  has_and_belongs_to_many :top_products
end