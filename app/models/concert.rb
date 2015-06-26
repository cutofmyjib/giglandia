class Concert < ActiveRecord::Base
  validates :venue, presence: true
  validates :city, presence: true
  validates :date, presence: true

  belongs_to :band
end

