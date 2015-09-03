class Band < ActiveRecord::Base
  # validates :name, presence: true

  # has_many :concerts
  has_many :fans
  has_many :users, through: :fans
end
