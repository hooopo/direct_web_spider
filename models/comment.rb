# encoding: utf-8
class Comment
  include Mongoid::Document

  field :title, :type => String
  field :content, :type => String
  field :author_name, :type => String
  field :star, :type => Integer
  field :publish_at, :type => Time
  
  embedded_in :product

end

