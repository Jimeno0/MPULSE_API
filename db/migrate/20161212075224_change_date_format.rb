class ChangeDateFormat < ActiveRecord::Migration[5.0]
  def change
    change_column :concerts, :date, :text
  end
end
