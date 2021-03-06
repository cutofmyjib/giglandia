class User < ActiveRecord::Base

  validates :username, presence: true
  validates :email, uniqueness: true
  has_many  :fans
  has_many  :bands, through: :fans

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def follow(band_id)
    fav = Band.where(songkick_id: band_id).first
    is_fave = self.bands.where(songkick_id: band_id).first
    if fav
      self.bands << fav unless is_fave
    else
      fav = Band.create(songkick_id: band_id)
      self.bands << fav
    end
  end

  def unfollow(band_id)
    fav = Band.where(songkick_id: band_id).first
    is_fave = self.bands.where(songkick_id: band_id).first
    if fav && is_fave
      is_fave.destroy
    end
  end

end
