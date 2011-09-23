# encoding: utf-8
require "open-uri"
require 'nokogiri'

module Spider
  class GomeFetcher < Fetcher
    URL = "http://www.gome.com.cn/allSort.html"

    def self.category_list
      html = open(URL).read
      html = html.force_encoding("UTF-8").encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "?") 
      doc = Nokogiri::HTML(html)
      doc.css("#allsort a").select{|x| x["href"].gsub(/\s+/, "") =~ /product/}.map do |elem|
        {
          :name => elem.inner_text,
          :url =>  elem["href"]
        }
      end
    end
  end
end

