# encoding: utf-8
require 'nokogiri'
require 'uri'
require File.expand_path(File.dirname(__FILE__) + "/../utils/utils")

module Spider
  class TmallPaginater < Paginater
    def pagination_list
      max_page  = doc.css("#totalPage").first.attr("value").to_i
      first_url = doc.css("#filterPageForm").attr("action").to_s
      uri  = URI.parse(first_url)
      hash = Utils.query2hash(uri.query)
      (1..max_page).map do |i|
        uri.query = Utils.hash2query(hash.merge("s" => hash["n"].to_i * (i - 1)))
        uri.to_s
      end
    end
  end
end