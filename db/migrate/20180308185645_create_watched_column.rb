class CreateWatchedColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :user_shows, :watched, :boolean, default: false
  end
end
