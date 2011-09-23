# encoding: utf-8
require 'nokogiri'

module Spider
  class JingdongParser < Parser
    def end_product
    end

    def merchant
    end

    def brand
    end

    def brand_type
    end

    def product_code
      doc.css("#summary li:first span").text.gsub(/(商品编号：)/,"")
    end

    def title
      doc.css("div#name h1/text()").text
    end

    def price
    end

    def price_url
      doc.css("strong.price img").first["src"]
    end

    def stock
      return 1 if doc.css("#stocktext").text =~ /发货/
      return 0 if doc.css("#stocktext").text =~ /售完/
      logger.info("stock issue!")
      0
    end

    def image_url
      doc.css("#preview img").first["src"]
    end

    def score
      doc.css("div[id^=star] div:first").first["class"].gsub(/[\D]+/, "").to_i
    end

    def standard
      doc.css(".Ptable").to_html
    end

    def desc
      doc.css(".mc.fore.tabcon").to_html
    end

    def comments
      #http://club.360buy.com/clubservice/productcomment-495087-5-0.+html
      []
    end

    def belongs_to_categories
      doc.css(".crumb a").select{|elem| elem["href"] =~ /products|com\/\w+\.html$/}.map do |elem|
        {
          :name => elem.inner_text,
          :url  => elem["href"]
        }
      end
    end
  end
end
