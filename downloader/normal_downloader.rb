# encoding: utf-8
require 'open-uri'
require 'timeout'
module Spider
  class NormalDownloader < Downloader
    def initialize(items)
      @items = items
    end

    def run
      @items.each do |item|
        begin
          html = open(item.url).read
        rescue Timeout::Error, Errno::ECONNREFUSED
          logger.error("#{item.class} #{item.kind} #{item.url} HTTP Connection Error.")
        else
          item = Encoding.set_utf8_html(item, html)
          if !Utils.valid_html?(item.html)
            logger.error("#{item.class} #{item.kind} #{item.url} Bad HTML.")
          else
            yield(item) 
          end
        end
      end
    end
  end
end
