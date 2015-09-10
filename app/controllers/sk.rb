module Songkick
  class Client
    include HTTParty

    base_uri "http://api.songkick.com/api/3.0"

    def initialize
      @apikey = ENV['SONGKICK_KEY']
    end

    def find_artist(band_name)
      response =  self.class.get("/search/artists.json",
                  query: { query: band_name,
                           apikey: ENV['SONGKICK_KEY'] })

      return response.to_hash
    end

    def find_events(band_id)
      response = self.class.get("/artists/" + "#{band_id}" +"/calendar.json",
                 query: { apikey: ENV['SONGKICK_KEY'] })
      return response.to_hash
    end
  end
end