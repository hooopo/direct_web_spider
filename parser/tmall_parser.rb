# encoding: utf-8
require 'nokogiri'

module Spider
  class TmallParser < Parser

    # 商品名称
    def title
      doc.css("#detail h3/a").text
    end

    # 市场价
    def price
      doc.css("#J_StrPrice").text.to_f
    end

    #图片价格
    def price_url
    end

    #库存
    def stock
      doc.css("#J_SpanStock").text.to_i
    end

    #分数
    def score
      #http://rate.taobao.com/detail_rate.htm?userNumId=512671209&auctionNumId=8762509426&showContent=1%C2%A4tPage=1&ismore=0&siteID=2
      #TODO
      0
    end

    def desc
    end

    #规格参数
    def standard
      doc.css(".attributes-list").to_html
    end

    # 商品图片
    def image_url
      doc.css("#J_ImgBooth").first["src"]
    end

    # 商品代码
    def product_code
    end

    #评论
    def comments
      []
    end

    def end_product
    end

    def merchant
    end

    def brand
    end

    def brand_type
    end
  end
end
