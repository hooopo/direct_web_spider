# encoding: utf-8
require "nokogiri"

module Spider
  class GomeParser < Parser
    def title
      doc.css("#name").inner_text.strip
    end

    def price
    end

    def stock
      1
    end

    def image_url
      doc.css(".p_img_bar img").first["src"]
    end

    def desc
      doc.css(".description").inner_html
    end

    def price_url
      doc.css("#gomeprice img").first["src"]
    end

    def score
      doc.css("#positive div.star").first["class"][/\d+/,0].to_i
    end

    def product_code
      doc.css("#sku").inner_text
    end

    def standard
      doc.css(".Ptable").inner_html
    end

    def comments
      #http://www.gome.com.cn/appraise/getAppraise.do
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

    def belongs_to_categories
      doc.css("#navigation a").select{|elem| elem["href"] && elem["href"].to_s !~ /index|brand/}.map do |elem|
        {
          :name => elem.inner_text,
          :url  => elem["href"].sub("..", "http://www.gome.com.cn")
        }
      end
    end
  end
end
