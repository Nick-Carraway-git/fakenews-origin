class CreateUserBoardrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_boardrooms do |t|
      t.references :user, foreign_key: true
      t.references :boardroom, foreign_key: true

      t.timestamps
    end
  end
end
