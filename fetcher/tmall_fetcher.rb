# encoding: utf-8
require 'open-uri'
require 'nokogiri'

module Spider
  class TmallFetcher < Fetcher
    URL = "http://www.tmall.com/go/rgn/mall/iwanttobuy-data.php?d=20110910"
    BLACK_LIST = ["http://list.tmall.com/50025135/g,guydamrvge2dkorxga4tmmbmguydamrzgyzdoorwgyzdmnjmguydamrvg44dgorugmzdsnzmguydamrvgi3dkorshe2tiojmguydamrvg44diorugyytinzmguydamrvg44dsorsga4tcnjmguydamrvg44dqorsgeztgnbmguydamrvgizdoorsgi3tkojmguydamrvgi3dgorrge4dcojmguydamrvgi2tqortge4tonjmguydamrvgi3teorygi2tolbvgaydenjsgy3dumzvgu2dglbvgaydenjsgmztunrwgizcynjqgaztcmzzg45dcmbsgy4cynjqga2dqnrsha5dsmzugywdkmbqgi2toobxhiytinjqgiwdkmbqgi2tqmrrhizdenjqgywdkmbqgi3tenbthiztenrzfq2tambsguytkmr2gy3tanrmguydanbxge3daorsguytanrmguydanbxgm2tmorrha3dsmzmguydanbxgm2toorrhe4dmnzmguydamrvg44tkoruhe2dklbvgaydenjyga3dumzqge3synjqgazdkobsg45dgmzrgawdkmbqgi2tqmrvhiytcnjsgywdkmbqgi2tqmzxhiytanbxfq2tambwgq3donr2gyztombm--0----------------------g-d-----40-0--50025233-x.htm?is=cate",
      "http://list.tmall.com/50025133/g-s----g,zsu3f7i-40-0-107021-50025133-x.htm?is=brand",
      "http://list.tmall.com/50030788/g-s-----40-0--50067261-x.htm?TBG=47894.93147.6",
      "http://list.tmall.com/50024410/g-st-----40-0--50094901-x.htm?TBG=19621.15481.26&",
      "http://list.tmall.com/50072285/g,guydanzsgmytmorrgizdolbvgaydomrtge4dumrshewdkmbqg4zdgmjzhi3tgla--0----------------------g-td--1---40-0--50072318-x.htm?is=cate",
      "http://list.tmall.com/50072030/g,guydanzsga4dcortge2dslbvgaydomrqguytumzqge3cynjqga3tembvga5dinzsfq2tambxgiydioj2geztmmrmguydanzsga2dqorygezcynjqga3tembug45dcmryhewdkmbqg4zdanbwhi2tqnzufq2tambxgiydinj2gm2tolbvgaydomrqgqzdunbyga2cynjqga3tembugq5dcmbzg4wdkmbqg4zdamzshiytqobqfq2tambxgiydgmz2gmzdkmzmguydanzsgaztcorrgqwa------------------------g-st-----40-0--50072042-x.htm",
      "http://list.tmall.com/50025137/g-st-----40-0--50025139-x.htm?TBG=19624.15484.2",
      "http://list.tmall.com/50025137/g-d-----40-0--50025139-x.htm?is=cate",
      "http://list.tmall.com/50025137/g,guydamzygm3tgorvga2synjqgaztqmzwhe5deobwfq2tambthaztmnj2gi3dslbvgaydgobtg4ydumjzgqwdkmbqgm4dgnzrhiytkmzmguydamzygm3teorzg4wdkmbqgm4dgnryhi4tala------------------------g-d-----40-0--50038373-x.htm?is=cate",
      "http://list.tmall.com/50024803/g,guydamrvge2diorzgi4cynjqgazdiobsgi5diobrfq2tambsgq4demz2gi3tolbvgaydenbygi2dumrtgywdkmbqgi2dqmrvhiytoojmguydamzuha2tcoruhawdkmbqgm2dqnjthiztsmrmguydamzuha2teoruguwa------------------------g-s-----40-0--50025144-x.htm?is=cate",
      "http://list.tmall.com/50024803/g,guydamrvge2diorzgi4cynjqgazdiobsgi5diobrfq2tambsgq4demz2gi3tolbvgaydenbygi2dumrtgywdkmbqgi2dqmrvhiytoojmguydamzuha2tcoruhawdkmbqgm2dqnjthiztsmrmguydamzuha2teoruguwa------------------------g-s-----40-0--50024822-x.htm?is=cate",
      "http://list.tmall.com/50026637/g,guydamrwgyztqortgm2dkobmguydamzug4zdoorugm3tonzmguydamzug4ztaorug44dmmrmguydamrwgy2taorugu4danrmguydamzug4zdsorvga4dmlbvgaydenrwgq3tumzzgy3cynjqgazdmnrvge5dembuhewdkmbqgi3dmnbzhiytknjufq2tambtgq3tenj2giytonbm------------------------g-st-----40-0--50034727-x.htm",
      "http://list.tmall.com/50026637/g,guydamrwgyztqortgm2dkobmguydamzug4zdoorugm3tonzmguydamzug4ztaorug44dmmrmguydamrwgy2taorugu4danrmguydamzug4zdsorvga4dmlbvgaydenrwgq3tumzzgy3cynjqgazdmnrvge5dembuhewdkmbqgi3dmnbzhiytknjufq2tambtgq3tenj2giytonbm------------------------g-d-----40-0--50026651-x.htm",
      "http://list.tmall.com/50024803/g-d-----40-0--50024574-x.htm?TBG=19624.15484.44",
      "http://list.tmall.com/search_product.htm?style=w&sort=s&start_price=20&n=20&s=0&cat=50076596&is=cate",
      "http://list.tmall.com/search_product.htm?style=w&sort=s&q=%EF%BF%BD%D6%A5&n=20&s=0&brand=20066&cat=2&is=brand",
      "http://list.tmall.com/50026391/g,guydanbqhaydmorsg4ytclbvgaydimbyga4dunbsgqwdkmbqgqydqmbzhi2tmlbvgaydimbygeydumjtgqysynjqgaztcnjygi5donbqfq------------------------w-s-----4-0--50040808-x.htm?is=cate",
      "http://list.tmall.com/50026391/g,guydanbqhaydmorsg4ytclbvgaydimbyga4dunbsgqwdkmbqgqydqmbzhi2tmlbvgaydimbygeydumjtgqysynjqgaztcnjygi5donbqfq------------------------w-s-----4-0--50040806-x.htm?is=cate",
      "http://list.tmall.com/search_shop.htm?q=%D4%CB%B6%AF%B7%FE&user_action=initiative&at_topsearch=1&sort=st&type=s&cat=",
      "http://list.tmall.com/50036640/g,guydamrwgmydqorsgmzdslbvgaydenrtgeytumjqgu2cynjqgazdomzwge5demryfq2tambsg4ztmnj2gmydenjmguydamrxgm3tkorwga4tslbvgaydenzugi2dumzqha3cynjqgazdonbsgu5dqnbmguydamrxgqzdmorug4wdkmbqgi3timrxhi2demjmguydamrxgqzdqorugezcynjqgazdonbshe5dgmjrfq2tambsg42dgmb2gm2delbvgaydenzugmytumjqgmysynjqgazdonbtgm5dkmzufq2tambsg42dgnb2gy2dclbvgaydenzugm2tumjxhaycynjqga3temrugi5dcnjmguydanzsgi2dgorrg43cynjqga3temrugq5dimbmguydanzsgi2dkorrguwdkmbqg4zdenbwhi2dqobmguydanzsgi2tiorrg43cynjqga3temrvgu5dmnjtfq2tambxgizdkoj2geydgmjmguydanzsgi3daorugyzcynjqga3temrwge5dcmzyfq------------------------g-d-----40-0--50027365-x.htm?is=cate",
      "http://list.tmall.com/50072285/g,guydanzsgi4dmoryge3synjqga3temryg45dcmbtg4wdkmbqg4zdeobyhiytqlbvgaydomrshezduobvgqwdkmbqg4zdgmbrhi2dcnjmguydanzsgmydkorsgi4delbvgaydomrtge2tumjwge2synjqga3temzsge5dsobxfq2tambxgiztgnz2gezdomjmguydanzsgm3dsorygu2dglbvgaydomrugi4tumzxhaysy--0----------------------g-td--1---40-0--50072286-x.htm?is=cate&prt=1302521823507&prc=1",
      "http://list.tmall.com/50072285/g,guydanzsgm3tcorrg42dglbvgaydomrthaztumzqguwdkmbqg4zdgobuhi2dimrqfq2tambxgiztqnj2ge2tilbvgaydomrtha3dunjzguwdkmbqg4zdgobxhiztolbvgaydomrtha4dumjxguwdkmbqg4zdgobzhiztklbvgaydomrtheytumrxfq2tambxgiztsmz2gi3dqlbvgaydomruga4tumztfq2tambxgi2dcnr2gy3cynjqga3tenbsga5denrufq2tambxgi2demr2geztklbvgaydomrugiztumrygmwdkmbqg4zdimruhiytcnrmguydanzsgqzdkorrgizsynjqga3tenbsgy5demzyfq--0----------------------g-td--1---40-0--50072384-x.htm?is=cate",
      "http://list.tmall.com/50072285/g,guydanzsgi4dmoryge3synjqga3temryg45dcmbtg4wdkmbqg4zdeobyhiytqlbvgaydomrshezduobvgqwdkmbqg4zdgmbrhi2dcnjmguydanzsgmydkorsgi4delbvgaydomrtge2tumjwge2synjqga3temzsge5dsobxfq2tambxgiztgnz2gezdomjmguydanzsgm3dsorygu2dglbvgaydomrugi4tumzxhaysy--0----------------------g-td--1---40-0--50072287-x.htm?is=cate",
      "http://list.tmall.com/50034368/g,guydamzugqydsorsgy3dklbvgaydgnbuga2tumzwgiwdkmbqgm2dimjrhizdkmbmguydamzugqytaorsguycy------------------------g-d-----40-0--50034409-x.htm?is=cate",
      "http://list.tmall.com/50034368/g,guydamzugqydsorsgy3dklbvgaydgnbuga2tumzwgiwdkmbqgm2dimjrhizdkmbmguydamzugqytaorsguycy------------------------g-d-----40-0--50043496-x.htm?is=cate",
      "http://list.tmall.com/50072436/g,guydanzsgq4tqoruha2dalbvgaydomruhe4tumjsha3cynjqga3tenjqga5dgmzwfq2tambxgi2tamj2ha3tqlbvgaydomrvgaztumrugqwdkmbqg4zdkmbuhi3dkobm------------------------g-td-----40-0--50072498-x.htm?is=cate",
      "http://list.tmall.com/50072436/g,guydanzsgq4tqoruha2dalbvgaydomruhe4tumjsha3cynjqga3tenjqga5dgmzwfq2tambxgi2tamj2ha3tqlbvgaydomrvgaztumrugqwdkmbqg4zdkmbuhi3dkobm------------------------g-td-----40-0--50072504-x.htm?is=cate",
      "http://list.tmall.com/50072436/g,guydanzsguztqorygmwdkmbqg4zdkmzzhi3delbvgaydomrvgqydumjtgywdkmbqg4zdknbrhizdklbvgaydomrvgqzdumrzguwdkmbqg4zdknbthiytqlbvgaydomrvgq3duojxfq2tambxgi2tinz2he2cynjqga3tenjuha5dknbvfq2tambxgi2tioj2gezdanjm------------------------g-td-----40-0--50072542-x.htm?is=cate",
      "http://list.tmall.com/50072436/g,guydanzsgu3dgoryfq2tambxgi2tmnb2he4synjqga3tenjwgu5dsmjvfq2tambxgi2tmnz2giwdkmbqg4zdknryhi4cynjqga3tenjxga5dknrufq2tambxgi2tomj2gyzcy------------------------g-td-----40-0--50072565-x.htm?is=cate",
      "http://list.tmall.com/50072436/g,guydanzsgu2tsortha4cynjqga3tenjwga5diobyfq2tambxgi2tmmj2gm3cy------------------------g-td-----40-0--50072559-x.htm?is=cate",
      "http://list.tmall.com/50072436/g,guydanzsguztqorygmwdkmbqg4zdkmzzhi3delbvgaydomrvgqydumjtgywdkmbqg4zdknbrhizdklbvgaydomrvgqzdumrzguwdkmbqg4zdknbthiytqlbvgaydomrvgq3duojxfq2tambxgi2tinz2he2cynjqga3tenjuha5dknbvfq2tambxgi2tioj2gezdanjm------------------------g-td-----40-0--50072546-x.htm?is=cate",
      "http://list.tmall.com/50072436/g,guydanzsgu2tiorsgizsynjqga3tenjvgu5dcmrxgewdkmbqg4zdknjwhi4tilbvgaydomrvgu3tumjqgywa------------------------g-td-----40-0--50072554-x.htm?is=cate",
      "http://list.tmall.com/50072436/g,guydanzsgu2tsortha4cynjqga3tenjwga5diobyfq2tambxgi2tmmj2gm3cy------------------------g-td-----40-0--50072560-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamzrgq3dmorwgaztolbvgaydgmjugyzdumrqgy4cynjqgaztcnbwgu5dcnjsgqwdkmbqgmytinruhi3dcobmguydamzrgq3dcortgq2synjqgaztcnbwgm5demjxfq2tambtge2dmnz2geycy------------------------g-s-----40-0--50031466-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamzrgq3dmorwgaztolbvgaydgmjugyzdumrqgy4cynjqgaztcnbwgu5dcnjsgqwdkmbqgmytinruhi3dcobmguydamzrgq3dcortgq2synjqgaztcnbwgm5demjxfq2tambtge2dmnz2geycy------------------------g-s-----40-0--50031465-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamzrgq2tgoryhe4dglbvgaydgmjugu2dumzyge3cynjqgaztcnbvgi5denrwgqwdkmbqgmytinjvhi3tonrmguydamzrgq3daorugu3synjqgaztcnbvg45deojqfq2tambtge2dkoj2gi3tslbvgaydgmjugu4dumrxhewdkmbqgmytinjwhizdamjm------------------------g-s-----40-0--50031453-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamzrgq2tgoryhe4dglbvgaydgmjugu2dumzyge3cynjqgaztcnbvgi5denrwgqwdkmbqgmytinjvhi3tonrmguydamzrgq3daorugu3synjqgaztcnbvg45deojqfq2tambtge2dkoj2gi3tslbvgaydgmjugu4dumrxhewdkmbqgmytinjwhizdamjm------------------------g-s-----40-0--50031452-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamzrgq2tgoryhe4dglbvgaydgmjugu2dumzyge3cynjqgaztcnbvgi5denrwgqwdkmbqgmytinjvhi3tonrmguydamzrgq3daorugu3synjqgaztcnbvg45deojqfq2tambtge2dkoj2gi3tslbvgaydgmjugu4dumrxhewdkmbqgmytinjwhizdamjm------------------------g-s-----40-0--50031454-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamrvga2dgorsgiydmnjmguydamrvga2deorrg4ztiobmguydamrvga3dcorrgeydkmjmguydamrvga2dcorrga3dqnbmguydamrvga3dmorxgizdilbvgaydenjqgy4tunbrha4cynjqgazdkmbxge5deobthewdkmbqgi2tanzshizdqmrvfq2tambsguydmnj2gi3tcojmguydamzthe4dgorsgu4dklbvgaydgmzzhazdumjrgu3synjqgazdkmbxg45dmobqfq2tambsguydinb2gyztglbvgaydenjqg43dunrrgywdkmbqgm2tanjshiytimjm------------------------g-s-----40-0--50025065-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamrvga2dgorsge2timzmguydamrvga2deorrg43tembmguydamrvga3dcorrga2taojmguydamrvga2dcorrgaydgnbmguydamrvga3dmorxg44telbvgaydenjqgy4tunbugy2cynjqgazdkmbxgi5dgmbtgewdkmbqgi2tanrvhizdqmryfq2tambsguydomj2gi3tgnzmguydamzthe4dgorsgu3telbvgaydgmzzhazdumjtgy4synjqgazdkmbxg45dqobxfq2tambsguydinb2gyzdolbvgaydenjqg43dunbvgiwdkmbqgm2tanjshiytanjm------------------------g-s-----40-0--50025041-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamrvga4tcorvhe4delbvgaydenjqhezdumjxgaycynjqgazdkmbzgy5dcnrxgiwdkmbqgi2taojvhiytmnrvfq2tambsguydsnb2ge2dkmbmguydamzygm2tqorzgqycynjqgazdkmjqgi5dsnbqfq2tambsguytanb2gu3dglbvgaydenjqheydunjwgmwdkmbqgi2taojthiztonbmguydamrvga4toorrhazsynjqgazdkmjqga5dcnztfq2tambsguydsob2ge3dslbvgaydgnjqgq4dumrzfq2tambsguytamz2gizcy------------------------g-s-----40-0--50025090-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamrvga2dgorsge4tqnjmguydamrvga2deorrg43tenbmguydamrvga3dcorrgeydcnzmguydamrvga2dcorzhe3tclbvgaydenjqgy3dunzwgmycynjqgazdkmbwhe5dimrtgewdkmbqgi2tanzshizdqnrtfq2tambsguydomj2gi3tcnzmguydamrvga3dkorsgy4dglbvgaydgmzzhaztumrvgiycynjqgaztgojygi5dcmjthawdkmbqgi2tanzxhi3tqmbmguydamrvga2diorwg4ycynjqgazdkmbxgy5dmmbsfq2tambtguydkmr2geytcla------------------------g-s-----40-0--50025036-x.htm?is=cate",
      "http://list.tmall.com/50023647/g,guydamrvga2dgorsge4tqnjmguydamrvga2deorrg43tenbmguydamrvga3dcorrgeydcnzmguydamrvga2dcorzhe3tclbvgaydenjqgy3dunzwgmycynjqgazdkmbwhe5dimrtgewdkmbqgi2tanzshizdqnrtfq2tambsguydomj2gi3tcnzmguydamrvga3dkorsgy4dglbvgaydgmzzhaztumrvgiycynjqgaztgojygi5dcmjthawdkmbqgi2tanzxhi3tqmbmguydamrvga2diorwg4ycynjqgazdkmbxgy5dmmbsfq2tambtguydkmr2geytcla------------------------g-s-----40-0--50025046-x.htm?is=cate",
      "http://list.tmall.com/50025137/g,guydamrvgeztsorrgi2tslbvgaydenjrgqydumjtga2cynjqgazdkmjuge5dcnjzgqwdkmbqgm4demzyhiztgnzmguydamzuha2doortg4wdkmbqgm2dqnbwhi3tsnrm------------------------g-d-----40-0--50038238-x.htm?is=cate",
      "http://list.tmall.com/50029836/g,guydamzqgaztqorwheysynjqgaztambuga5dimztfq2tambtgu2danb2gmytelbvgaydgnjuga2tumjzgewdkmbqgmydamzzhiytqmrmguydamzvgqydmorrg44cynjqga2dimbzha5dcnzsfq2tambtguztsmj2ge2tslbvgaydombthe2tumjqguwdkmbqgm2tgobyhi4tklbvgaydgnjtha4tunrwfq2tambtgu2dgoj2gi2cynjqga3tamzzg45dcmzmguydanzqgm4tmorrgmwa------------------------g-s-----40-0--50035389-x.htm?is=cate",
      "http://list.tmall.com/50045002/g,guydanbxgmydoorwha2synjqga2dkmbqgq5dcmjwfq2tambugu4tqmz2ha4cynjqga3tcojxha5demrmguydanbvgaydgorrgmwa-2-----------------------g-d-----40-0--50045003-x.htm?is=cate",
      "http://list.tmall.com/50024897/g-s--99---40-0--50026022-x.htm?TBG=19622.15482.57"
    ]
    
    def self.category_list
      html = open(URL).read
      html = html.force_encoding("GB18030").encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "?")
      categories = html.scan(/\((.*?)\)/).map do |x|
        hash = eval(x[0].gsub(/"class".*?\}/, "}"))
        {:name => hash[:name], :url => hash[:href]}
      end
      categories.select do |category|
        category[:url] =~ /http:\/\/list\.tmall\.com/ && category[:url] !~ /catid_count/ && !BLACK_LIST.include?(category[:url])
      end
    end
  end
end
