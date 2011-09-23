# encoding: utf-8
require 'open-uri'
require 'nokogiri'

module Spider
  class SuningFetcher < Fetcher
    URL      = "http://www.suning.com/webapp/wcs/stores/servlet/SNProductCatgroupView?storeId=10052&catalogId=10051&flag=1"
    BASE_URL = "http://www.suning.com"

    def self.category_list
      html = open(URL).read
      html = html.encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "?") 
      doc = Nokogiri::HTML html
      doc.css(".contentmain .allProContent .cont-left/a").map do |elem|
        {
          :name => elem.inner_text,
          :url  => File.join(BASE_URL, elem["href"])
        }
      end
    end
  end
end
