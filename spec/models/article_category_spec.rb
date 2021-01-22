require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do
  let!(:article) { create(:article) }
  let!(:category) { create(:category) }
  let!(:article_category) { create(:article_category, article_id: article.id,
                                                     category_id: category.id) }

  describe "ArticleCategoryモデルの作成" do
    it "親記事、カテゴリーがあれば有効" do
      expect(article_category).to be_valid
    end

    it "親記事なしは無効" do
      article_category.article_id = nil
      expect(article_category).not_to be_valid
    end

    it "カテゴリーなしは無効" do
      article_category.category_id = nil
      expect(article_category).not_to be_valid
    end
  end

  describe "ArticleCategoryモデルの依存性" do
    it "記事が消えると中間レコードも消える" do
      expect do
        article.destroy
      end.to change(ArticleCategory, :count).by(-1)
    end

    it "カテゴリー消えると中間レコードも消える" do
      expect do
        category.destroy
      end.to change(ArticleCategory, :count).by(-1)
    end
  end
end
