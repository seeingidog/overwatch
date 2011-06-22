require 'rubygems'
require 'spork'

Spork.prefork do 
  $: << File.join(File.dirname(__FILE__), "../lib")
  require 'overwatch'
  require 'rspec'
  require 'rack/test'
  require 'factory_girl'

  # set :environment, :test
  
  Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }
  Dir[File.join(File.dirname(__FILE__), "factories/**/*.rb")].each { |f| require f }
  
  RSpec.configure do |config|
    config.color_enabled = true
    config.formatter = "documentation"
    config.include Rack::Test::Methods
    
    config.before(:each) do
    end
    
    config.before(:suite) do
      Overwatch.redis.flushall
    end
  end
  
  def app
    Overwatch::Application.new
  end
end

Spork.each_run do
  
end