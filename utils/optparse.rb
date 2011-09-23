# encoding: utf-8
require 'optparse'

SpiderOptions = {  
  :name        => "dangdang",  
  :environment => (ENV['SPIDER_ENV'] || "development").dup,
  :downloader  => "normal",
  :number      => 1000
}  

ARGV.clone.options do |opts|  
  opts.on("-s", "--name=spider_name", String,  
    "input spider name to run",
    "Default: dangdang"
  ) { |v| SpiderOptions[:name] = v }

  opts.on("-e", "--environment=name", String,  
    "Specifies the environment to run this spider under (development/production).",
    "Default: development"
  ) { |v| SpiderOptions[:environment] = v }

  opts.on("-d", "--downloader=name", String,
    "Specifies the downloader to run this spider under (normal/ty/em)",
    "Default: normal"
  ) {|v| SpiderOptions[:downloader] = v}
  
  opts.on("-n", "--number=number", Integer,
    "Specifies the number to load from database.",
    "Default: 1000"
  ){|v| SpiderOptions[:number] = v}

  opts.separator ""  

  opts.on("-h", "--help", "Show this help message.") { puts opts; exit }  

  opts.parse!  
end 

ARGV = [] #hack  irb with optparse's IRB::UnrecognizedSwitch bug
puts "Loading #{SpiderOptions[:name]}'s #{SpiderOptions[:environment]} spider environment..."
