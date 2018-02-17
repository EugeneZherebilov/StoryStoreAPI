class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :type
      t.string :image
      t.integer :count_players
      t.integer :access
      t.datetime :start_time
      t.timestamps
    end
  end
end