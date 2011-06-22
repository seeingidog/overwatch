module Overwatch
  class Application < Sinatra::Base
    
    get '/resources/:name_or_id/snapshots/?' do |name_or_id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      start_at = params[:start_at] || 1.hour.ago
      end_at = params[:end_at] || DateTime.now
      snapshots = resource.snapshots.all(:created_at.gte => start_at, :created_at.lte => end_at)
      if snapshots
        if params['attribute']
          attr = params['attribute']          
          results = snapshots.inject([]) do |ret, snap|
            value = snap.data.instance_eval(attr) rescue nil
            ret << { 
              :id => snap.id, 
              :created_at => snap.created_at, 
              :attribute => attr, 
              :value => value
            } 
          end
          results.to_json(:exclude => [ :updated_at ])
        else
          snapshots.to_json(:exclude => [ :updated_at ])
        end
      else
        [].to_json
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
    
    # GET past_hour
    get '/resources/:name_or_id/snapshots/past_hour/?' do |name_or_id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      snapshots = resource.snapshots.all(
        :created_at.gte => 1.hour.ago, 
        :created_at.lte => DateTime.now
      )      
      if snapshots
        status 200
        snapshots.to_json(:exclude => [ :updated_at ])
      else
        halt 404
      end
    end
    
    # GET past_day
    get '/resources/:name_or_id/snapshots/past_day/?' do |name_or_id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      snapshots = resource.snapshots.all(
        :created_at.gte => 1.day.ago, 
        :created_at.lte => DateTime.now
      )      
      if snapshots
        status 200
        snapshots.to_json(:exclude => [ :updated_at ])
      else
        halt 404
      end
    end
    
    # GET past_week
    get '/resources/:name_or_id/snapshots/past_week/?' do |name_or_id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      snapshots = resource.snapshots.all(
        :created_at.gte => 1.week.ago, 
        :created_at.lte => DateTime.now
      )      
      if snapshots
        status 200
        snapshots.to_json(:exclude => [ :updated_at ])
      else
        halt 404
      end
    end
    
    # GET past_month
    get '/resources/:name_or_id/snapshots/past_month/?' do |name_or_id|
      resource = Overwatch::Resource.find_by_name_or_id(name_or_id)
      snapshots = resource.snapshots.all(
        :created_at.gte => 1.month.ago, 
        :created_at.lte => DateTime.now
      )      
      if snapshots
        status 200
        snapshots.to_json(:exclude => [ :updated_at ])
      else
        halt 404
      end
    end
    
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