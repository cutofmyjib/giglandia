helpers do
  def get_songkick_name(band_id)
    query = Songkickr::Remote.new ENV['SONGKICK_KEY']
    p query.artist(band_id)
  end
end