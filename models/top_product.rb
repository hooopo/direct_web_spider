class TopProduct
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, unique: true
  field :order_num, :type=>Integer,:default=>0

  has_many :middle_products,:dependent=>:destroy
  has_and_belongs_to_many :merchants

end
