class User < ActiveRecord::Base
  has_secure_password
  has_many :user_shows
  has_many :shows, through: :user_shows

  def slug
    username.downcase.scan(/[a-z0-9]+/).join('-')
  end

  def self.find_by_slug(slug)
    all.find { |e| e.slug == slug }
  end
end
