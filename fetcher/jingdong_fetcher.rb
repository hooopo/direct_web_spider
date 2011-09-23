# encoding: utf-8
require 'open-uri'
require 'nokogiri'

module Spider
  class JingdongFetcher < Fetcher
    URL = "http://www.360buy.com/allSort.aspx"
    BaseURL = "http://www.360buy.com"

    def self.category_list
      html = open(URL).read
      html = html.force_encoding("GB18030").encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "?") 
      doc = Nokogiri::HTML(html)
      doc.css("div.mc  em a[@href ^=products]").map do |elem|
        {
          :name => elem.inner_text,
          :url => File.join(BaseURL, elem["href"])
        }
      end
    end
  end
end
