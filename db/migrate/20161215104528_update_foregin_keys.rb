class UpdateForeginKeys < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :concerts, :users
    remove_foreign_key :artists, :users
    add_foreign_key :concerts, :users, on_delete: :cascade
    add_foreign_key :artists, :users, on_delete: :cascade
  end
end
