# encoding: utf-8
require 'eventmachine'
require 'em-http-request'
require File.expand_path(File.dirname(__FILE__) + "/../utils/utils")

module Spider
  class EmDownloader < Downloader
    def initialize(items)
      @items = items
    end

    def run
      EventMachine.run do 
        @items.each do |item|
          http = EventMachine::HttpRequest.new(item.url).get
          http.callback do
            html = http.response
            item = Encoding.set_utf8_html(item, html)
            if !Utils.valid_html?(item.html)
              logger.error("#{item.class} #{item.kind} #{item.url} Bad HTML.")
            else
              yield(item) 
            end
          end
          http.errback do
            logger.error("#{item.class} #{item.kind} #{item.url} HTTP Connection Error.")
          end
        end
      end 
    end
  end
end
