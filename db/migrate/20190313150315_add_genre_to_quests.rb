class AddGenreToQuests < ActiveRecord::Migration[5.2]
  def change
  add_column :quests, :genre, :string
  end
end
