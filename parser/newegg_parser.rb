# encoding: utf-8
require 'nokogiri'

module Spider
  class NeweggParser < Parser

    def title
      doc.css(".proHeader h1").inner_text
    end

    def price
    end

    def stock
      doc.css(".detailList span.lightly").inner_text == "有货" ? 1 : 0
    end

    def image_url
      doc.css("a#bigImg").first["href"]
    end

    def price_url
      doc.css(".neweggPrice img").first["src"]
    end

    def score
      score = doc.css(".score span")
      score.empty? ? 0 : score.first.inner_text.to_f
    end

    def desc
    end

    def standard
      doc.css(".proDescTab table").to_html
    end

    # 商品代码
    def product_code
    end

    def comments
      doc.css("#comment_1 .listCell").map do |elem| 
        {
          :title => elem.css(".title h2").inner_text,
          :publish_at => Time.parse(elem.css(".pubDate").inner_text), 
          :star => elem.css(".rankIcon strong").inner_text.to_f,
          :content => elem.css(".content .textBlock").map{|block| block.inner_text}.join("\n")
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
  end
end

