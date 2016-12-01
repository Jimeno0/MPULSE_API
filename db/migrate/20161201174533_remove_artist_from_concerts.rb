class RemoveArtistFromConcerts < ActiveRecord::Migration[5.0]
  def change
    remove_column :concerts, :artist_id
  end
end
