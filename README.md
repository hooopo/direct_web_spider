# direct_web_spider
direct_web_spider is direct web spider framwork for ruby.

Requirements
------------
  * Ruby1.9.2+
  * sudo apt-get install libcurl4-gnutls-dev
  * bundle install

Features
------------
* 将定向爬取网站抽象成几个独立的过程(Fetcher, Paginater, Digger, Parser)
* 封装爬取所需的通用功能，让开发者只需关心网页信息抽取逻辑
* 编码处理模块
* 日志模块,方便调试和错误跟踪
* 多种下载接口（单线程、多线程、Event IO）,并可以随时切换
* 简单图片识别功能（针对电子商务网站价格信息为图片的情况）

Run
------------
* 运行顺序
  1. ruby script/run_fetcher
  2. ruby script/run_paginater
  3. ruby script/run_digger 
  4. ruby script/run_parser
* 启动参数: ruby script/run_parser -eproduction -dty -sdangdang -n500
  * -e指定环境（production/development）默认为development.
  * -d为以什么方式下载(ty->多线程，normal ->单线程, em -> EventIO)默认为normal,推荐使用ty参数
  * -s为指定运行哪个网站(dangdang,jingdong,etc)默认是当当
  * -n为指定一次爬取多少条记录，默认1000
  * -h为帮助信息
  * 
  
------

[db-china.org](https://db-china.org)
