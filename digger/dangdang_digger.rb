# encoding: utf-8
require 'nokogiri'
module Spider
  class DangdangDigger < Digger
    def product_list 
      doc.css(".mode_goods div.name/a").map{|elem| elem["href"]}
    end
  end
end
