class AddConcertIdToConcerts < ActiveRecord::Migration[5.0]
  def change
    add_column :concerts, :concert_id, :string
  end
end
