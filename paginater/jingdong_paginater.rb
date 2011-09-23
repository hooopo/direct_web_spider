# encoding: utf-8
module Spider
  class JingdongPaginater < Paginater
    def pagination_list
      max_page = doc.css("div.pagin a").map{|elem| elem.children.text.to_i}.max || 1
      (1..max_page).map{|i| url.sub(".html", "-0-0-0-0-0-0-0-1-1-#{i}.html")}
    end
  end
end
