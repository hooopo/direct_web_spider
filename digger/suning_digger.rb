# encoding: utf-8
require 'nokogiri'

module Spider
  class SuningDigger < Digger
    def product_list 
      base_url = "http://www.suning.com"
      doc.css("#product_container li .pro_img a").map{|elem| base_url + elem["href"]}
    end
  end
end
