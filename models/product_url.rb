# encoding: utf-8
class ProductUrl
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  attr_accessor :html

  scope :from_kind, ->(kind){where(:kind => kind)}

  field :url, :type => String, :unique => true
  field :completed, :type => Boolean, :default => false
  field :kind, :type => String
  field :retry_time, :type => Integer, :default => 0
  field :page_id, :type => BSON::ObjectId
  

  belongs_to :page
  has_one :product

  validates_presence_of :url
  validates_uniqueness_of :url
end
