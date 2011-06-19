module Overwatch
  class Event::WebHook < Event
   property :url, Array
   property :data, Hash
   property :headers, Hash
    
    def run(snapshot, check, rule)
      res = RestClient.post self.url, self.data, self.headers
      # res.body
    end # run
    
  end # Event::Email
end # Overwatch