class AddCompletedAndSoOnToQuests < ActiveRecord::Migration[5.2]
  def change
    add_column :quests, :completed, :boolean
    add_column :quests, :due_date, :date
  end
end
