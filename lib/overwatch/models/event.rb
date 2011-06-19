module Overwatch
  class Event
    include DataMapper::Resource
    
    property :id, Serial, :index => true
    property :created_at, DateTime
    property :updated_at, DateTime
    
    has n, :checks, :through => :check_event
    
    def run(snapshot, check, resource)
    end
  end # Event
end # Overwatch

require 'overwatch/models/event/email'
require 'overwatch/models/event/sms'
require 'overwatch/models/event/http'
require 'overwatch/models/event/stdout'
require 'overwatch/models/event/xmpp'