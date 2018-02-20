class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups, id: :uuid do |t|
      t.references :user, type: :uuid, index: true, foreign_key: { on_delete: :cascade }
      t.string :name
      t.string :description
    end
  end
end