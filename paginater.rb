# encoding: utf-8
require "nokogiri"
require File.expand_path(File.dirname(__FILE__) + "/logger")

module Spider
  class Paginater 
    include Spider::Logger

    attr_reader :doc, :url

    def initialize(item)
      @url = item.url
      @doc = Nokogiri::HTML(item.html)
    end
  end

  autoload :DangdangPaginater,    File.join(File.dirname(__FILE__), "paginater", "dangdang_paginater")
  autoload :JingdongPaginater,    File.join(File.dirname(__FILE__), "paginater", "jingdong_paginater")
  autoload :TmallPaginater,       File.join(File.dirname(__FILE__), "paginater", "tmall_paginater")
  autoload :NeweggPaginater,      File.join(File.dirname(__FILE__), "paginater", "newegg_paginater")
  autoload :GomePaginater,        File.join(File.dirname(__FILE__), "paginater", "gome_paginater")
  autoload :SuningPaginater,      File.join(File.dirname(__FILE__), "paginater", "suning_paginater")
end

