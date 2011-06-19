require 'yajl'
require 'haml'
require 'sinatra/base'
require 'redis'
require 'ohm'
require 'ohm/contrib'
require 'mail'
require 'hashie'
require 'rest-client'
require 'ruby-debug'
require 'resque'

require 'overwatch/version'
require 'overwatch/application'

require 'overwatch/snapshot'
require 'overwatch/resource_check'
require 'overwatch/check_event'

require 'overwatch/resource'
require 'overwatch/rule'
require 'overwatch/check'
require 'overwatch/check_run'
require 'overwatch/event'

require 'overwatch/routes/resource'
require 'overwatch/routes/snapshot'
require 'overwatch/routes/check'

module Overwatch
  
  class << self
    def config_file_path
      @config_file_path ||= 
        File.expand_path(File.join(File.dirname(__FILE__), "../config/overwatch.yml"))
    end
      
    def config
      @config ||= YAML.load_file(config_file_path)
    end
    
    def redis
      @redis = Redis.new
    end
  end
end
