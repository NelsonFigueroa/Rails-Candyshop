class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string "name", :limit => 25
      t.string "city", :limit => 25
      t.timestamps
    end
  end
end
