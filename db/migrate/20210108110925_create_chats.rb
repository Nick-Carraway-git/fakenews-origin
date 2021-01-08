class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.text :message
      t.references :user, foreign_key: true
      t.references :boardroom, foreign_key: true

      t.timestamps
    end
  end
end
