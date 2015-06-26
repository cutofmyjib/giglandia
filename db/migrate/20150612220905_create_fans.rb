class CreateFans < ActiveRecord::Migration
  def change
    create_table :fans, id: false do |t|
      t.integer :band_id
      t.integer :user_id
    end

    add_index :fans, :band_id
    add_index :fans, :user_id
  end
end
