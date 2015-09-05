class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      # t.string :name, null: false
      t.integer :songkick_id, null: false, index: true

      t.timestamps
    end
  end
end
