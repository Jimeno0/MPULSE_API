class CreateConcerts < ActiveRecord::Migration[5.0]
  def change
    create_table :concerts do |t|
      t.string :name
      t.datetime :date
      t.string :url
      t.string :genre
      t.string :subgenre
      t.boolean :sale
      t.string :image
      t.string :lat
      t.string :lon
      t.string :city
      t.string :venue
      t.references :artist, foreign_key: true

      t.timestamps
    end

    
  end
end
