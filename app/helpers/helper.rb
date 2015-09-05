helpers do
  def get_songkick_name(band_ids)
    bands = []
    band_ids.each do |id|
      query = Songkickr::Remote.new ENV['SONGKICK_KEY']
      bands.push(query.artist(id))
    end
    bands
  end

  def get_events(artist_name)
    query = Songkickr::Remote.new ENV['SONGKICK_KEY']
    query.events(artist_name)
  end
end