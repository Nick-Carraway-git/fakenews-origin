require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "Favoriteモデルの作成" do
    it "ユーザー、対象の記事があれば有効" do
      favorite = build(:favorite)
      expect(favorite).to be_valid
    end

    it "ユーザーなしは無効" do
      favorite = build(:favorite, user_id: nil)
      expect(favorite).not_to be_valid
    end

    it "対象の記事なしは無効" do
      favorite = build(:favorite, article_id: nil)
      expect(favorite).not_to be_valid
    end
  end
end
