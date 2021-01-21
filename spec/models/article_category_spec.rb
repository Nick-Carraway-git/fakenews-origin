require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do
  describe "ArticleCategoryモデルの作成" do
    it "親記事、カテゴリーがあれば有効" do
      article_category = build(:article_category)
      expect(article_category).to be_valid
    end

    it "親記事なしは無効" do
      article_category = build(:article_category, article_id: nil)
      expect(article_category).not_to be_valid
    end

    it "カテゴリーなしは無効" do
      article_category = build(:article_category, category_id: nil)
      expect(article_category).not_to be_valid
    end
  end
end
