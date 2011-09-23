class EndProduct
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, unique: true

  belongs_to :middle_product
end