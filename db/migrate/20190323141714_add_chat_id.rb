class AddChatId < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :category_id, :integer
  end
end
