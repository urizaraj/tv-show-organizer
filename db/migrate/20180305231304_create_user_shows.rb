class CreateUserShows < ActiveRecord::Migration[5.1]
  def change
    create_table :user_shows do |t|
      t.integer :user_id
      t.ingeger :show_id
    end
  end
end
