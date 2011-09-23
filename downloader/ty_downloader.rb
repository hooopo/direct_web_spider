# encoding: utf-8
require 'typhoeus'
require File.expand_path(File.dirname(__FILE__) + "/../utils/utils")

module Spider
  class TyDownloader < Downloader
    def initialize(items)
      @items = items
      @hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
    end

    def run
      @items.each do |item|
        request = Typhoeus::Request.new(item.url)
        request.on_complete do |response|
          if !response.timed_out? && response.success?
            html = response.body
            Encoding.set_utf8_html(item, html)
            if !Utils.valid_html?(item.html)
              logger.error("#{item.class} #{item.kind} #{item.url} Bad HTML.")
            else
              yield(item)
            end
          elsif response.timed_out?
            logger.error("#{item.class} #{item.kind} #{item.url} HTTP Connection Error.")
          elsif response.code == 0
            logger.error("#{item.class} #{item.kind} #{item.url} HTTP Connection Error.")
          else
            logger.error("#{item.class} #{item.kind} #{item.url} HTTP Connection Error.")
          end
        end
        @hydra.queue(request)
      end
      @hydra.run
    end
  end
end

