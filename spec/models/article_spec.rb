require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "Articleモデルの作成" do
    it "タイトル、本文、画像説明文、ユーザーがあれば有効" do
      article = build(:article_model)
      expect(article).to be_valid
    end

    it "タイトルなしは無効" do
      article = build(:article_model, title: nil)
      expect(article).not_to be_valid
    end

    it "タイトルが70字を超えると無効" do
      article = build(:article_model, title: 'a' * 80)
      expect(article).not_to be_valid
    end

    it "本文なしは無効" do
      article = build(:article_model, content: nil)
      expect(article).not_to be_valid
    end

    it "本文が4000字を超えると無効" do
      article = build(:article_model, content: 'a' * 4100)
      expect(article).not_to be_valid
    end

    it "画像説明文なしは無効" do
      article = build(:article_model, image_description: nil)
      expect(article).not_to be_valid
    end

    it "画像説明文が70字を超えると無効" do
      article = build(:article_model, image_description: 'a' * 80)
      expect(article).not_to be_valid
    end

    it "ユーザーなしは無効" do
      article = build(:article_model, user_id: nil)
      expect(article).not_to be_valid
    end
  end
end
