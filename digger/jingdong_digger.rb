# encoding: utf-8
require 'nokogiri'

module Spider
  class JingdongDigger < Digger
    def product_list 
      doc.css("#plist ul.list-h div.p-img a").map{|elem| elem["href"]}
    end
  end
end
