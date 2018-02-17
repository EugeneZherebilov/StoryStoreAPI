class ChangeTypeGames < ActiveRecord::Migration[5.1]
  def change
    rename_column :games, :type, :type_id
  end
end
