class UpdateForeginKeys < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :concerts, :artists
    add_foreign_key :concerts, :artists, on_delete: :cascade
  end
end
