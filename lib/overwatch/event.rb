module Overwatch
  class Event < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    include Ohm::Boundaries
    
    set :check_events, Overwatch::CheckEvent
    
    def checks
      Overwatch::CheckEvent.find(:event_id => self.id).map do |rc|
        Overwatch::Check[rc.check_id]
      end
    end
    
    def run(snapshot, check, resource)
    end
  end # Event
end # Overwatch

require 'overwatch/event/email'
require 'overwatch/event/sms'
require 'overwatch/event/http'
require 'overwatch/event/stdout'
require 'overwatch/event/xmpp'