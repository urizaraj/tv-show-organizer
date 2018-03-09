class Show < ActiveRecord::Base
  has_many :user_shows
  has_many :users, through: :user_shows

  validates :name, presence: true
  validates :year,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1940,
              less_than_or_equal_to: 2300
            }
end
