# encoding: utf-8
require "nokogiri"

module Spider
  class SuningParser < Parser
    def title
      doc.css(".product_title_name").inner_text
    end

    def price
    end

    def stock
      doc.css("#deleverStatus").inner_text =~ /现货/ ? 1 : 0
    end

    def image_url
      doc.css(".product_b_image img").first["src"]
    end

    def desc
    end

    def price_url
    end

    def score
      5 - doc.css(".sn_stars em.noscore").count
    end

    def product_code
      doc.css(".product_title_cout").inner_text[/\d+/, 0].to_i
    end

    def standard
      ""
    end

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

    def belongs_to_categories
      doc.css(".path a").select{|elem| elem["href"] =~ /html/}.map do |elem|
        {
          :name => elem.inner_text,
          :url  => elem["href"]
        }
      end
    end
  end
end
