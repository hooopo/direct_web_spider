# encoding: utf-8
#!/usr/bin/env ruby
require File.expand_path(File.dirname(__FILE__) + "/logger")

module Spider
  class Fetcher
    include Spider::Logger
  end
  autoload :DangdangFetcher,     File.join(File.dirname(__FILE__), "fetcher", "dangdang_fetcher")
  autoload :JingdongFetcher,     File.join(File.dirname(__FILE__), "fetcher", "jingdong_fetcher")
  autoload :TmallFetcher,	 File.join(File.dirname(__FILE__), "fetcher", "tmall_fetcher")
  autoload :NeweggFetcher,	 File.join(File.dirname(__FILE__), "fetcher", "newegg_fetcher")
  autoload :SuningFetcher,       File.join(File.dirname(__FILE__), "fetcher", "suning_fetcher")
  autoload :GomeFetcher,         File.join(File.dirname(__FILE__), "fetcher", "gome_fetcher")
end
