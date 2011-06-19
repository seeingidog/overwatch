module Overwatch
  class Snapshot
    include DataMapper::Resource
    
    property :id, Serial, :index => true
    property :created_at, DateTime
    property :updated_at, DateTime
        
    attr_accessor :data
    attr_accessor :raw_data
    
    belongs_to :resource
    
    after :create, :parse_data
    after :create, :run_checks
    
    def parse_data
      raw_data = Yajl.dump(self.raw_data)
      Overwatch.redis.setnx "overwatch::snapshot:#{self.id}:data", raw_data
    end
    
    def data
      Hashie::Mash.new(
        Yajl.load(Overwatch.redis.get "overwatch::snapshot:#{self.id}:data")
      )
    end
    
    def run_checks
      self.resource.run_checks
    end
  end # class Snapshot 
end # module Overwatch