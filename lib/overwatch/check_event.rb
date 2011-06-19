module Overwatch
  class CheckEvent < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    include Ohm::Boundaries
    
    reference :check, lambda {|id| Overwatch::Check[id] }
    reference :event, lambda {|id| Overwatch::Event[id] }
    
    index :check
    index :event
  end
end
    