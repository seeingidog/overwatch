require 'sinatra/base'
require 'overwatch/helpers'
require 'overwatch/routes/resource'
require 'overwatch/routes/snapshot'
require 'overwatch/routes/check'

module Overwatch
  class Application < Sinatra::Base
    helpers Overwatch::Helpers
    
    configure do
      set :app_file, __FILE__
      set :logging, true
      set :run, false
      set :show_exceptions, false
      set :server, %w[ thin mongrel webrick ]
      set :raise_errors, false
    end
    
    configure(:development) do
      begin
        require 'sinatra/reloader'
        register Sinatra::Reloader
        also_reload File.join(File.dirname(__FILE__), 'models/resource')
        also_reload File.join(File.dirname(__FILE__), 'models/snapshot')
        also_reload File.join(File.dirname(__FILE__), 'routes/check')
        also_reload File.join(File.dirname(__FILE__), 'models/check_event')
        also_reload File.join(File.dirname(__FILE__), 'models/check_resource')
        also_reload File.join(File.dirname(__FILE__), 'models/event')
        also_reload File.join(File.dirname(__FILE__), 'models/rule')
        also_reload File.join(File.dirname(__FILE__), 'routes/resource')
        also_reload File.join(File.dirname(__FILE__), 'routes/check')
        also_reload File.join(File.dirname(__FILE__), 'routes/snapshot')
        
        also_reload File.join(File.dirname(__FILE__), 'helpers')
      rescue LoadError
        puts "sinatra-reloader gem missing. reloading disabled"
      end      
    end
    configure(:production) do
      set :redis_url, ENV['REDIS_URL'] || 'redis://localhost:6379/0'
    end
    
    before do
      content_type "application/json"
    end
    
  end
end