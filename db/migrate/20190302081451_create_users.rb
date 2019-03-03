class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :img
      t.timestamps null: false
      t.text :self
      t.string :zodiacsigns
    end
  end
end
