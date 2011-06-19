module Overwatch
  class Resource
    include DataMapper::Resource
    
    property :id, Serial, :index => true
    property :created_at, DateTime
    property :updated_at, DateTime
    property :name, String, :index => true, :unique => true, :required => true
    property :api_key, String, :index => true, :unique => true

    has n, :snapshots
    has n, :checks, :through => :check_resources
    has n, :events, :through => :checks
    
    before :create, :generate_api_key

    def snapshot_range(start_at=nil, end_at=nil)
      s = start_at || DateTime.now - 1.hour
      e = end_at || DateTime.now
      self.snapshots.all(:created_at.gte => s, :created_at.lte => e)
    end
    
    def previous_update
      snapshots[-1]
    end
    
    def last_update
      snapshots[-2]
    end
    
    def run_checks
      Resque.enqueue(CheckRun, self.id.to_s)
    end
    
    def regenerate_api_key
      generate_api_key
      self.save
    end
    
    def self.find_by_name_or_id(name_or_id)
      self.first(:id => name_or_id) || self.first(:name => name_or_id)
    end
    
    private
    
    def generate_api_key
      api_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..30]
      self.api_key = api_key
    end
    

     
  end # class Resource
end # module Overwatch