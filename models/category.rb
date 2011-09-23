# encoding: utf-8
class Category
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  before_destroy :move_children_to_parent
  
  attr_accessor :html

  scope :from_kind, ->(kind){where(:kind => kind)}

  field :url, :type => String, :unique => true
  field :completed, :type => Boolean, :default => false
  field :name, :type => String
  field :kind, :type => String
  field :retry_time, :type => Integer, :default => 0

  has_many :pages

  validates_presence_of :url
  validates_uniqueness_of :url
end
