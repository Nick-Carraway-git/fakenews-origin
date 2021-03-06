require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let!(:user) { create(:user) }
  let!(:article) { create(:article) }
  let!(:favorite1) { article.favorites.build(user_id: user.id) }
  let!(:favorite2) { article.favorites.create(user_id: user.id) }

  describe "Favoriteモデルの作成" do
    context "パラメータが正常な場合" do
      it "ユーザー、対象の記事があれば有効" do
        expect(favorite1).to be_valid
      end
    end

    context "パラメータが不正な場合" do
      it "ユーザーなしは無効" do
        favorite1.user_id = nil
        expect(favorite1).not_to be_valid
      end

      it "対象の記事なしは無効" do
        favorite1.article_id = nil
        expect(favorite1).not_to be_valid
      end
    end
  end

  describe "Favoriteモデルの依存性" do
    it "ユーザーが削除されると、お気に入りも削除" do
      expect do
        user.destroy
      end.to change(Favorite, :count).by(-1)
    end

    it "対象の記事が削除さると、お気に入りも削除" do
      expect do
        article.destroy
      end.to change(Favorite, :count).by(-1)
    end
  end
end
