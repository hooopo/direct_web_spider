# encoding: utf-8
require 'open-uri'
require 'json'

module Spider
  class DangdangFetcher < Fetcher
    URL = "http://www.dangdang.com/Found/category.js"

    def self.category_list
      html = open(URL).read
      html = html.encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "?") 
      
      if json = html[/json_category=(.*?)menudataloaded/m, 1] 
        hash = JSON.parse(json) 
      else
        raise "当当网页面结构改变了！"
      end

      hash.values.map do |h| 
        {
          :name => h["n"],
          :url => "http://" + h["u"].sub("#dd#", ".dangdang.com/")
        }
      end.select{|item| item[:url] =~ /list\?cat/}
    end
  end
end
