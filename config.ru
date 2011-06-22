require 'rubygems'
require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'] ? ENV['RACK_ENV'] : :production)

require 'resque/server'
require 'resque_scheduler'
require 'resque/scheduler'

$: << File.join(File.dirname(__FILE__), "lib")

require 'overwatch'

run Rack::URLMap.new(
  "/"       => Overwatch::Application.new,
  "/resque" => Resque::Server.new
)
