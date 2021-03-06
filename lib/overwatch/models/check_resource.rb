module Overwatch
  class CheckResource
    include DataMapper::Resource
    
    property :id, Serial, :index => true
    property :created_at, DateTime
    property :updated_at, DateTime
    
    belongs_to :check
    belongs_to :resource
    
  end
end