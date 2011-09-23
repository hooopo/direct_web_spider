# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/logger")

module Spider
  class Digger
    include Spider::Logger

    attr_reader :url, :doc

    def initialize(page)
      @url = page.url
      @doc = Nokogiri::HTML(page.html)
    end
  end
  
  autoload :DangdangDigger,           File.join(File.dirname(__FILE__), "digger", "dangdang_digger")
  autoload :JingdongDigger,           File.join(File.dirname(__FILE__), "digger", "jingdong_digger")
  autoload :TmallDigger,              File.join(File.dirname(__FILE__), "digger", "tmall_digger")
  autoload :NeweggDigger,             File.join(File.dirname(__FILE__), "digger", "newegg_digger")
  autoload :SuningDigger,             File.join(File.dirname(__FILE__), "digger", "suning_digger")
  autoload :GomeDigger,               File.join(File.dirname(__FILE__), "digger", "gome_digger")
end
