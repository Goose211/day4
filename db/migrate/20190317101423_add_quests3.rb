class AddQuests3 < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :day, :string
    add_column :quests, :day2, :string
  end
end
