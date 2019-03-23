class CreateChats < ActiveRecord::Migration[5.2]
  def change
      create_table :chats do |t|
      t.string :chattitle
      t.string :img3
      t.text :chatcoment
      t.integer :user_id
      t.string :user_name
      t.timestamps null: false
    end
  end
end
