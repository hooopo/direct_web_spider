# encoding: utf-8
require 'nokogiri'

module Spider
  class NeweggPaginater < Paginater
    def pagination_list
      max_page = doc.css(".pageNav a/*").map{|elem| elem.inner_text.to_i}.max
      (1..max_page).map{|i| url.sub(".htm", "-#{i}.htm")}
    end
  end
end
