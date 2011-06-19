module Overwatch
  class Model
    include DataMapper::Resource
    
    property :id, Serial, :index => true
    property :created_at, DateTime
    property :updated_at, DateTime
    
  end
end