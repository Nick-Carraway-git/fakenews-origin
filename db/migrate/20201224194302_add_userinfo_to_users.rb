class AddUserinfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, nill: false, unique: true
    add_column :users, :introduce, :string
    add_column :users, :popularity, :integer
  end
end
