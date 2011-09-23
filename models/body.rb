# encoding: utf-8
class Body 
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
  field :text_info, :type => String
  field :image_info, :type => Array
  field :score, :type => Float
  field :standard, :type => String
  field :product_id, :type => BSON::ObjectId

  belongs_to :product
  embeds_many :comments

end

