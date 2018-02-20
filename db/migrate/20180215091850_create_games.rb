class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games, id: :uuid do |t|
      t.references :user, type: :uuid, index: true, foreign_key: { on_delete: :cascade }
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