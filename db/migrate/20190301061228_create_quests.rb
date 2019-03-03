class CreateQuests < ActiveRecord::Migration[5.2]
  def change
    create_table :quests do |t|
      t.string :title
      t.string :client
      t.string :star
      t.text :condition
      t.text :member
      t.text :details
      t.string :img2
      t.integer :user_id
      t.string :user_name
      t.timestamps null: false
    end
  end
end
