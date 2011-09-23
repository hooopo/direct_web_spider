# encoding: utf-8
require 'nokogiri'

module Spider
  class TmallDigger < Digger
    def product_list 
      doc.css(".product a").map{|elem| elem["href"]}
    end
  end
end
