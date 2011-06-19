require 'yajl'
require 'haml'
require 'sinatra/base'
require 'dm-core'
require 'dm-validations'
require 'dm-redis-adapter'
require 'dm-serializer'
require 'dm-types'
require 'dm-timestamps'
require 'mail'
require 'hashie'
require 'rest-client'
require 'resque'

DataMapper.setup(:default, { :adapter => 'redis' })

require 'active_support/core_ext'
# require 'active_support/core_ext/numeric/time'
# require 'active_support/core_ext/string/conversions'
# require 'active_support/core_ext/integer/time'
# require 'active_support/core_ext/time/calculations'
# require 'active_support/core_ext/date_time/calculations'


require 'overwatch/version'
require 'overwatch/application'

# Models
require 'overwatch/models/resource'
require 'overwatch/models/snapshot'
require 'overwatch/models/check'
require 'overwatch/models/check_resource'
require 'overwatch/models/rule'
require 'overwatch/models/event'
require 'overwatch/models/check_event'

# Resque Jobs
require 'overwatch/check_run'

# Routes
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
