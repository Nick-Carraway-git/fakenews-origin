class RemoveReplyIdFromMinimails < ActiveRecord::Migration[5.2]
  def change
    remove_column :minimails, :reply_id, :integer
  end
end
