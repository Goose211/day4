class AddQuests2 < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :title2, :string
    add_column :quests, :details2, :text
  end
end
