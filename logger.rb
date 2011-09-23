# encoding: utf-8
require 'logger'
module Spider
  module Logger
    def logger_file
      dir  = File.dirname(__FILE__) + "/log"
      if self.class != Object
        file = self.class.to_s.split("::")[-1].underscore + ".log"
      else
        file = File.basename($0).sub("_", "_#{SpiderOptions[:name]}_") + ".log"
      end
      File.join(dir, file)
    end

    def logger 
      @logger ||= begin
        @logger = ::Logger.new(self.logger_file)
        @logger.level = 0
        @logger.datetime_format = "%Y-%m-%d %H:%M:%S"
        @logger
      end
    end
  end
end