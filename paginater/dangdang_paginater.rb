# encoding: utf-8
module Spider
  class DangdangPaginater < Paginater
    def pagination_list
      max_page = doc.css("#all_num").text[/\d+/, 0].to_i
      (1..max_page).map{|i| "#{url}&p=#{i}"}
    end
  end
end
