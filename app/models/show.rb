class Show < ActiveRecord::Base
  has_many :user_shows
  has_many :users, through: :user_shows

  validates :name, presence: true
  validates :year, presence: true,
                   numericality: { only_integer: true, greater_than: 1940, less_than: 2300 }
end