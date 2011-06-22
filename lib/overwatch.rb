require 'bundler'
Bundler.require(:default)

DataMapper.setup(:default, { :adapter => 'redis' })
require 'resque_scheduler'
require 'resque/scheduler'

require 'active_support/core_ext'

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
require 'overwatch/jobs/check_run'
require 'overwatch/jobs/snapshot_reaper'
require 'overwatch/jobs/no_data_check'

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
