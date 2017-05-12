class ChangeColumnToMessage < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :body, :text, null: false
  end
end
