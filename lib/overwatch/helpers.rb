module Overwatch
  module Helpers
    def resources
      Overwatch::Resource.all.map do |r|
        r.to_hash
      end
    end
    
    def snapshots
      Overwatch::Resource.all.map do |s|; s.to_hash; end
    end
  end
end

