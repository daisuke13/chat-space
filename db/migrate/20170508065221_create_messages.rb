class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text        :body
      t.string      :image
      t.integer     :user_id, null: false
      t.integer     :group_id, null: false
      t.timestamps
    end

    add_reference :users, foreign_key: true
    add_reference :groups, foreign_key: true
  end
end
