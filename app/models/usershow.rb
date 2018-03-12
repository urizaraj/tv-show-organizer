class UserShow < ActiveRecord::Base
  belongs_to :user
  belongs_to :show

  def toggle_watched
    toggle!(:watched)
  end
end
