class CreateBoardrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :boardrooms do |t|
      t.string :name
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
