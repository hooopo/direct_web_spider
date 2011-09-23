# encoding: utf-8
class Page 
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  attr_accessor :html

  scope :from_kind, ->(kind){where(:kind => kind)}

  field :url, :type => String, :unique => true
  field :completed, :type => Boolean, :default => false
  field :kind, :type => String
  field :retry_time, :type => Integer, :default => 0
  field :category_id, :type => BSON::ObjectId

  belongs_to :category
  has_many :product_urls

  validates_presence_of :url
  validates_uniqueness_of :url
end

