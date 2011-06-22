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
    after :create, :schedule_reaper
    
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
    
    
    # Usage: to_dotted_hash({:one => :two}) # => "one.two"
    def to_dotted_hash(source=self.data,target = {}, namespace = nil)
      prefix = "#{namespace}." if namespace
      case source
      when Hash
        source.each do |key, value|
          to_dotted_hash(value, target, "#{prefix}#{key}")
        end
      # when Array
      #   source.each_with_index do |value, index|
      #     to_dotted_hash(value, target, "#{prefix}#{index}")
      #   end
      else
        target[namespace] = source
      end
      target
    end
    
    def schedule_reaper
      Resque.enqueue_in(30.days, SnapshotReaper, self)
    end
    
    def attribute_keys
      self.to_dotted_hash.keys
    end
    
  end # class Snapshot 
end # module Overwatch