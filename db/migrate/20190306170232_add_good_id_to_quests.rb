class AddGoodIdToQuests < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :good, :integer, default: 0
  end
end
