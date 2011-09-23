# encoding: utf-8
require 'nokogiri'

module Spider
  class DangdangParser < Parser
    def title
      doc.css("div.dp_wrap h1/text()").text
    end

    def price
      doc.css("#salePriceTag/text()").text.sub("￥", "").to_i
    end

    def stock
      #TODO 库存信息是ajax请求动态加载的。
      #http://205.186.156.35:8080/issues/24
      #库存信息：http://product.dangdang.com/callback.php?type=stock&product_id=1033397102&page_type=mall
      #@doc.search("span.location_area strong").text
      return 1
    end

    def image_url
      img = doc.css("#largePic")
      img.empty? ? "http://img32.ddimg.cn/7/35/60129142-1_h.jpg" : img.first["src"]
    end

    def desc
    end

    def price_url
    end

    def score
      doc.css("p.fraction img").select{|elem| elem["src"] =~ /red/}.size
    end

    def product_code
    end

    def standard
    end

    def comments
      title_elems      = doc.css("#comm_all h5 a/text()")
      content_elems    = doc.css("#comm_all div.text")
      publish_at_elems = doc.css("#comm_all .title .time/text()")
      star_elems       = doc.css("#comm_all .title .star")
      (0..title_elems.count-1).map do |i|
        {
          :title      => title_elems[i].inner_text,
          :content    => content_elems[i].inner_text.sub(/[\s\d:-]+/, ""),
          :publish_at => publish_at_elems[i].to_s.empty? ? Time.now : Time.parse(publish_at_elems[i].to_s),
          :star       => star_elems[i] ? star_elems[i].search("img").select{|img| img["src"] =~ /red/}.size : 0
        }
      end
    end

    def end_product
    end

    def merchant
    end

    def brand
    end

    def brand_type
    end

    def belongs_to_categories
      doc.css(".crumb a").select{|elem| elem["href"] =~ /list/}.map do |elem|
        {
          :name => elem.inner_text,
          :url  => elem["href"]
        }
      end
    end
  end
end
