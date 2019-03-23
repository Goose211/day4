class CreateFrees2 < ActiveRecord::Migration[5.2]
  def change
     create_table :frees2 do |t|
      t.string :freetitle
      t.string :img3
      t.text :freecoment
      t.integer :freeuser_id
      t.string :freeuser_name
      t.timestamps null: false
     end
  end
end
