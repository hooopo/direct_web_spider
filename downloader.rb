# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/encoding")
require File.expand_path(File.dirname(__FILE__) + "/logger")

module Spider
  class Downloader
    include Spider::Logger
    
    def max_concurrency
      10
    end
  end
  autoload :EmDownloader,     File.join(File.dirname(__FILE__), "downloader", "em_downloader")
  autoload :TyDownloader,     File.join(File.dirname(__FILE__), "downloader", "ty_downloader")
  autoload :NormalDownloader, File.join(File.dirname(__FILE__), "downloader", "normal_downloader")
end
