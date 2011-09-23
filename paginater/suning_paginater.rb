# encoding: utf-8
require 'nokogiri'
module Spider
  class SuningPaginater < Paginater
    def pagination_list
      base_url = "http://www.suning.com/webapp/wcs/stores/servlet/odeSearch?storeId=#{info[:store_id]}&catalogId=#{info[:catalog_id]}&categoryId=#{info[:category_id]}&suggestionWordList=#{info[:suggestion_list]}&isCatalogSearch=#{info[:is_catalog_search]}"
      max_page = doc.css("#pagetop span").inner_text.split("/").last.to_i 
      (1..max_page).map{|i| "#{base_url}&currentPage=#{i - 1}"}
    end

    private

    def info
      url_info = url.sub(/\.html$/, "").split(/_(?!\b)/)
      {
        :store_id => url_info[1],
        :catalog_id => url_info[2],
        :category_id => url_info[4],
        :suggestion_list => "",
        :lang_id => -7,
        :is_catalog_search => url_info[3]
      }
    end
  end
end
