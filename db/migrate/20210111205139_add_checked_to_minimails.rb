class AddCheckedToMinimails < ActiveRecord::Migration[5.2]
  def change
    add_column :minimails, :checked, :boolean, default: false, null: false
  end
end
