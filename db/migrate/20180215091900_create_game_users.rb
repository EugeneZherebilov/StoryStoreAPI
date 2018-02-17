class CreateGameUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :game_users, id: :uuid do |t|
      t.references :game, type: :uuid, index: true, foreign_key: { on_delete: :cascade }
      t.references :user, type: :uuid, index: true, foreign_key: { on_delete: :cascade }
    end
  end
end