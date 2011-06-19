module Overwatch
  class Application < Sinatra::Base
    
    get '/resources/:name_or_id/snapshots/?' do |name_or_id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      start_at = params[:start_at] || 1.hour.ago
      end_at = params[:end_at] || DateTime.now
      snapshots = resource.snapshots.all(:created_at.gte => start_at, :created_at.lte => end_at)
      # if params['attribute']
      #         attr = params['attribute']
      #         results = snapshots.inject([]) do |ret, snap|
      #           ret << { :_id => snap[:_id], :created_at => snap[:created_at], :attribute => attr, :value => snap.data[attr] }
      #         end
      #         results.to_json
      #       else
      if snapshots
        snapshots.to_json
      else
        halt 404
      end
      # end
    end # GET index

    post '/resources/:name_or_id/snapshots/?' do |name_or_id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      snapshot = resource.snapshots.new(:data => request.body.read)
      
      if snapshot.save
        body resquest.body.read.to_json
        snapshot.to_json
      else
        status 422
        snapshot.errors.to_json
      end
    end # POST
    
    get '/resources/:name_or_id/snapshots/:id/?' do |name_or_id, id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      snapshot = resource.snapshots.get(id)
      if snapshot
        status 200
        snapshot.to_json
      else
        halt 404
      end
    end # GET show

    delete '/resources/:name_or_id/snapshots/:id/?' do |name_or_id, id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      snapshot = resource.snapshots.get(id)
      if snapshot
        if snapshot.delete
          status 204
          snapshot.to_json
        else
          status 409
          snapshot.errors.to_json
        end
      else
        halt 404
      end
    end # DELETE
    
    get '/resources/:name_or_id/snapshots/:id/data/?' do |name_or_id, id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      snapshot = resource.snapshots.get(id)
      if snapshot
        status 200
        snapshot.data.to_json
      else
        halt 404
      end
    end

  end # Application
end # Overwatch