class CreateArticleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :article_categories do |t|
      t.references :article, index: true
      t.references :category, index: true
      t.timestamps
    end
  end
end
