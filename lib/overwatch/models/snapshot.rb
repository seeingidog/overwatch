module Overwatch
  class Snapshot
    include DataMapper::Resource
    
    property :id, Serial, :index => true
    property :created_at, DateTime
    property :updated_at, DateTime
    property :data, Json
        
    belongs_to :resource
    
    after :create, :run_checks
    
    def data=(value)
      @data = Yajl.dump(value)
    end
    
    def data
      Hashie::Mash.new(Yajl.load(@data))
    end
    
    def run_checks
      self.resource.run_checks
    end
  end # class Snapshot 
end # module Overwatch