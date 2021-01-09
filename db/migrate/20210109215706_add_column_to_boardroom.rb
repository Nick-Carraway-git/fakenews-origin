class AddColumnToBoardroom < ActiveRecord::Migration[5.2]
  def change
    add_reference :boardrooms, :user, foreign_key: true
  end
end
