class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :venue, null: false
      t.string :city, null: false
      t.date :date, null: false
      t.time :time
      t.decimal :price
      t.integer :band_id

      t.timestamps
    end
  end
end
