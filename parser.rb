# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/logger")

module Spider
  class Parser
    include Spider::Logger

    attr_reader :doc, :product
    
    def initialize(product)
      @product = product
      @doc = Nokogiri::HTML(product.html)
    end

    def attributes
      {
        :kind => product.kind,
        :title => title,
        :product_code => product_code,
        :price => price,
        :price_url => price_url,
        :stock => stock,
        :image_url => image_url,
        :score => score,
        :desc => desc,
        :standard => standard,
        :comments => comments,
        :end_product => end_product,
        :merchant => merchant,
        :brand => brand,
        :brand_type => brand_type,
        :product_url_id => product.id
      }
    end
  end

  autoload :DangdangParser,           File.join(File.dirname(__FILE__), "parser", "dangdang_parser")
  autoload :JingdongParser,           File.join(File.dirname(__FILE__), "parser", "jingdong_parser")
  autoload :TmallParser,              File.join(File.dirname(__FILE__), "parser", "tmall_parser")
  autoload :NeweggParser,             File.join(File.dirname(__FILE__), "parser", "newegg_parser")
  autoload :SuningParser,             File.join(File.dirname(__FILE__), "parser", "suning_parser")
  autoload :GomeParser,               File.join(File.dirname(__FILE__), "parser", "gome_parser")
  
end