class CreateMinimails < ActiveRecord::Migration[5.2]
  def change
    create_table :minimails do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.integer :reply_id
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
