class AddCategoryIdToQuests < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :category_id, :integer
  end
end
