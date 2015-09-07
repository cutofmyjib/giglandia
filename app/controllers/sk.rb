require 'dotenv'
Dotenv.load

module Songkick
  class Client
    include HTTParty

    base_uri "http://api.songkick.com/api/3.0/"

    def find_artist(band_name)
      response = self.class.get("/search/artists.json?",
        :headers => { :apikey => ENV['SONGKICK_KEY']},
        :query => { :query => band_name }
        )

      return response.to_hash
    end
  end
end