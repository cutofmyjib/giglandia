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

  def get_thumbnails(band_ids)
    thumbnails = []
    band_ids.map do |band_id|
      input = 'songkick:artist:' + band_id.to_s
      echonest = Echowrap.artist_images(id: input, results: 1)
      thumbnails.push(echonest)
    end
    thumbnails
  end
end