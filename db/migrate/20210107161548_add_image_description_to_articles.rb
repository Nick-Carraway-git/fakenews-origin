class AddImageDescriptionToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :image_description, :text
  end
end
