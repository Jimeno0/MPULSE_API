class CreateArtistsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :artists_users do |t|
        t.references :artist, foreign_key: true
        t.references :user, foreign_key: true
    end
  end
end
