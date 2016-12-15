class UpdateForeginKeys < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :concerts, :concerts_users
    remove_foreign_key :artists, :artists_users
    add_foreign_key :concerts, :concerts_users, on_delete: :cascade
    add_foreign_key :artists, :artists_users, on_delete: :cascade
  end
end
