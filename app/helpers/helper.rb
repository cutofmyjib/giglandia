helpers do
  def query_songkickr
    #memoize
    @songkickr ||= Songkickr::Remote.new ENV['SONGKICK_KEY']
  end

  def init_songkick
    @songkick ||= Songkick::Client.new
  end

  def get_songkick_name(band_ids)
    bands = []
    band_ids.each do |id|
      bands.push(query_songkickr.artist(id))
    end
    bands
  end

  def get_events(artist_name)
    query_songkickr.events(artist_name)
  end

  def get_gig_count(band_ids)
    batch_count = []
    band_ids.each do |id|
      count = init_songkick.find_events(id)
      batch_count.push(count["resultsPage"]["totalEntries"])
    end
    return batch_count
  end

  def get_thumbnails(band_ids)
    thumbnails = []
    band_ids.each do |band_id|
      input = 'songkick:artist:' + band_id.to_s
      echonest = Echowrap.artist_images(id: input, results: 1)
      thumbnails.push(echonest)
    end
    thumbnails
  end

  def partial(template, locals={})
    erb(template, :layout => false, :locals => locals)
  end
end