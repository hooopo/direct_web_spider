# encoding: utf-8
module Spider
  module Encoding
    Map = {
      "dangdang"  => "GB18030",
      "jingdong"  => "GB18030",
      "newegg"    => "GB18030",
      "tmall"     => "GB18030",
      "suning"    => "UTF-8",
      "gome"      => "UTF-8"
    }

    def self.set_utf8_html(item, html)
      origin_encoding = Map[item.kind]
      item.html = html.force_encoding(origin_encoding).encode("UTF-8",  :undef => :replace, :replace => "?", :invalid => :replace)
      return item
    end
  end
end
