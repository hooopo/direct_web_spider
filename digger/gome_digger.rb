#encoding: utf-8
require "nokogiri"

module Spider
  class GomeDigger < Digger
    def product_list 
      doc.css("#plist .p-img a").map{|elem| elem["href"]}
    end
  end
end

