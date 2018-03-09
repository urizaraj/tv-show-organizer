class User < ActiveRecord::Base
  has_many :user_shows
  has_many :shows, through: :user_shows
  validates :username, uniqueness: { case_sensitive: false },
                       presence: true,
                       format: { with: /[A-Za-z0-9\-_]+/ }

  validates :email, presence: true
  has_secure_password

  def slug
    username.downcase.scan(/[a-z0-9]+/).join('-')
  end

  def self.find_by_slug(slug)
    all.find { |e| e.slug == slug }
  end
end
