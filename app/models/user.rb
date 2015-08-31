class User < ActiveRecord::Base
  validates :username, :password, presence: true
  validates :email, uniqueness: true
  has_many :fans
  has_many :bands, through: :fans

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def follow band_name
    self.bands << band_name
  end

end
