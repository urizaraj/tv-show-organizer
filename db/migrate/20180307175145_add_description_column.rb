class AddDescriptionColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :shows, :description, :string
  end
end
