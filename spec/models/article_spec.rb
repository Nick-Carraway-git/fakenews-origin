require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "Articleモデルの作成" do
    let!(:user) { create(:user) }
    let(:article) { create(:article, user_id: user.id) }

    context "パラメータが正常な場合" do
      it "タイトル、本文、画像説明文、ユーザーがあれば有効" do
        expect(article).to be_valid
      end
    end

    context "パラメータが不正な場合(タイトル)" do
      it "タイトルなしは無効" do
        article.title = ''
        expect(article).not_to be_valid
      end

      it "タイトルが70字を超えると無効" do
        article.title = 'a' * 80
        expect(article).not_to be_valid
      end
    end

    context "パラメータが不正な場合(本文)" do
      it "本文なしは無効" do
        article.content = ''
        expect(article).not_to be_valid
      end

      it "本文が4000字を超えると無効" do
        article.content = 'a' * 4100
        expect(article).not_to be_valid
      end
    end

    context "パラメータが不正な場合(画像説明文)" do
      it "画像説明文なしは無効" do
        article.image_description = ''
        expect(article).not_to be_valid
      end

      it "画像説明文が70字を超えると無効" do
        article.image_description = 'a' * 80
        expect(article).not_to be_valid
      end
    end

    context "パラメータが不正な場合(ユーザー)" do
      it "投稿ユーザーなしは無効" do
        article.user_id = nil
        expect(article).not_to be_valid
      end
    end
  end

  describe "Articleの依存性" do
    let!(:user1) { create(:user) }
    let!(:article1) { create(:article, user_id: user1.id) }

    it "投稿ユーザーが削除されると、記事も削除" do
      expect do
        user1.destroy
      end.to change(Article, :count).by(-1)
    end
  end
end
