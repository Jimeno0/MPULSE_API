class AddCountryToConcerts < ActiveRecord::Migration[5.0]
  def change
    add_column :concerts, :country, :string
  end
end
