class MiddleProduct
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, unique: true

  belongs_to :top_product
  has_many :end_products,:dependent=>:destroy
end

