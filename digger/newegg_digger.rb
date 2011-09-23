# encoding: utf-8
require 'nokogiri'

module Spider
  class NeweggDigger < Digger
    def product_list 
      doc.css("#itemGrid1 div.itemCell  dt/a").map{|elem| elem["href"]}
    end
  end
end

