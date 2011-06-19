module Overwatch
  class ResourceCheck < Ohm::Model
    include Ohm::Timestamping
    include Ohm::Typecast
    include Ohm::Callbacks
    include Ohm::ExtraValidations
    include Ohm::Boundaries
    
    reference :resource, lambda {|id| Overwatch::Resource[id] }
    reference :check, lambda {|id|  Overwatch::Check[id] }
    
    index :resource
    index :check
    
  end
end