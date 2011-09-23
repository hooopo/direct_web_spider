# encoding: utf-8
require 'nokogiri'

module Spider
  class GomePaginater < Paginater
    def pagination_list
      max_page = doc.css(".thispage").inner_text.split("/").last.to_i 
      (1..max_page).map do |i|
        "http://search.gome.com.cn/product.do?" + info.merge(:p => i).map{|pairs| pairs.join("=") }.join("&")
      end
    end

    def info
      array = url.scan(/\d+/)
      {
        :topCtgyId => array[0],
        :ctgyId => array[1],
        :order => 3,
        :ctgLevel => array[2],
        :scopes => ""
      }
    end
  end
end

