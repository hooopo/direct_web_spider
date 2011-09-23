# encoding: utf-8
require 'open-uri'
require 'nokogiri'

module Spider
  class NeweggFetcher < Fetcher
    URL = "http://www.newegg.com.cn/CategoryList.htm"

    def self.category_list
      html = open(URL).read
      html = html.encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "?")
      doc  = Nokogiri::HTML(html) 
      doc.css(".allCateList dd a").map do |elem|
        {
          :url  => elem["href"],
          :name => elem.inner_text
        }
      end
    end
  end
end 
