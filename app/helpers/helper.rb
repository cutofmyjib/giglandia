helpers do
  def get_songkick_name(band_ids)
    bands = []
    band_ids.each do |band|
      query = Songkickr::Remote.new ENV['SONGKICK_KEY']
      bands.push(query.artist(band.songkick_id))
    end
    bands
  end
end